//
//  ViewController.swift
//  NasaRoverProject
//
//  Created by Zeynep Baştuğ on 13.11.2022.
//

import UIKit

import Alamofire
import Kingfisher

class MainViewController: UIViewController, UIScrollViewDelegate, UITabBarDelegate, UITabBarControllerDelegate {
    
    @IBOutlet weak var detailsView: UIView!
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var roverImage: UIImageView!
    
    @IBOutlet weak var roverName: UILabel!
    
    @IBOutlet weak var cameraName: UILabel!
    
    @IBOutlet weak var launchDate: UILabel!
    
    @IBOutlet weak var landingDate: UILabel!
    
    @IBOutlet weak var photoDate: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var sol: UIStepper!
    
    @IBOutlet weak var filter: UIBarButtonItem!
    
    var lastPage = 1
    var imagesList:[Photo] = []
    var tab = ["curiosity","opportunity","spirit"]
    var isLoading:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsView.isHidden = true
        detailsView.layer.masksToBounds = true;
        imagesCollectionView.register(UINib(nibName:"ImCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        let appearance = UITabBarAppearance()
        changeColor(itemAppearance: appearance.stackedLayoutAppearance)
        changeColor(itemAppearance: appearance.inlineLayoutAppearance)
        changeColor(itemAppearance: appearance.compactInlineLayoutAppearance)
        
        tabBarController?.delegate = self
        tabBarController?.tabBar.standardAppearance = appearance
        tabBarController?.tabBar.scrollEdgeAppearance = appearance
        let navappearance = UINavigationBarAppearance()
        
        navappearance.backgroundColor = UIColor(named: "navicolor")
        navappearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.standardAppearance = navappearance
        navigationController?.navigationBar.compactAppearance = navappearance
        navigationController?.navigationBar.scrollEdgeAppearance = navappearance
        
        getData(url:"https://api.nasa.gov/mars-photos/api/v1/rovers/" + tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=" + String(lastPage) + "&api_key=PTjRgetceu6ECw3BuwlOghhsp2PhOdmFfygP8qPi")
        setupMenu()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        AppDelegate.selectedIndex = tabBarController.selectedIndex
        detailsView.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (imagesCollectionView.contentSize.height-scrollView.frame.size.height) {
            if (isLoading) {
                return
            }
            lastPage+=1
            getData(url:"https://api.nasa.gov/mars-photos/api/v1/rovers/" + tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=" + String(lastPage) + "&api_key=DEMO_KEY")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = imagesList[indexPath.row]
        downloadImages(image: photo.img_src!, imageView: roverImage)
        roverName.text = photo.rover?.name
        landingDate.text = photo.rover?.landing_date
        photoDate.text = photo.earth_date
        cameraName.text = photo.camera?.name
        launchDate.text = photo.rover?.launch_date
        status.text = photo.rover?.status
        detailsView.isHidden = false
        detailsView.layer.zPosition = 2
        collectionView.layer.opacity = 3
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        detailsView.isHidden = true
    }
    
    @IBAction func solChanged(_ sender: Any) {
        self.imagesList = []
        self.lastPage = 1
        self.getData(url:"https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(sol.value) + "&page=" + String(self.lastPage) + "&api_key=DEMO_KEY")
    }
    
    func changeColor(itemAppearance:UITabBarItemAppearance)
    {
        itemAppearance.normal.iconColor = UIColor.black
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        itemAppearance.selected.iconColor = UIColor.blue
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
    }
    
    func setupMenu() {
        let fhaz = UIAction(title: "Front Hazard Avoidance Camera", image: UIImage(systemName: "plus")) { (action) in
            self.imagesList = []
            self.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=1&camera=fhaz&api_key=DEMO_KEY")
        }
        let rhaz = UIAction(title: "Rear Hazard Avoidance Camera", image: UIImage(systemName: "plus")) { (action) in
            self.imagesList = []
            self.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=1&camera=rhaz&api_key=DEMO_KEY")
            
        }
        let mast = UIAction(title: "Mast Camera", image: UIImage(systemName: "plus")) { (action) in
            self.imagesList = []
            self.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=1&camera=mast&api_key=DEMO_KEY")
            
        }
        let chemcam = UIAction(title: "Chemistry and Camera Complex", image: UIImage(systemName: "plus")) { (action) in
            self.imagesList = []
            self.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=1&camera=chemcam&api_key=DEMO_KEY")
            
        }
        let mahli = UIAction(title: "Mars Hand Lens Imager", image: UIImage(systemName: "plus")) { (action) in
            
            self.imagesList = []
            self.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=1&camera=mahli&api_key=DEMO_KEY")
            
        }
        
        let mardi = UIAction(title: "Mars Descent Imager", image: UIImage(systemName: "plus")) { (action) in
            self.imagesList = []
            self.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=1&camera=mardi&api_key=DEMO_KEY")
            
        }
        
        let navcam = UIAction(title: "Navigation Camera", image: UIImage(systemName: "plus")) { (action) in
            self.imagesList = []
            self.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=1&camera=navcam&api_key=DEMO_KEY")
            
        }
        
        let pancam = UIAction(title: "Panoramic Camera", image: UIImage(systemName: "plus")) { (action) in
            self.imagesList = []
            self.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=1&camera=pancam&api_key=DEMO_KEY")
            
        }
        
        let minites = UIAction(title: "Miniature Thermal Emission Spectrometer", image: UIImage(systemName: "plus")) { (action) in
            self.imagesList = []
            self.getData(url: "https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=1&camera=minites&api_key=DEMO_KEY")
            
        }
        
        let noFilter = UIAction(title: "No Filter", image: UIImage(systemName: "minus"), attributes: .destructive) {
            (action) in
            self.imagesList = []
            self.getData(url:"https://api.nasa.gov/mars-photos/api/v1/rovers/" + self.tab[AppDelegate.selectedIndex] + "/photos?sol=" + String(self.sol.value) + "&page=" + String(self.lastPage) + "&api_key=DEMO_KEY")
        }
        let menu = UIMenu(title: "Filter", children: [fhaz,rhaz,mast,chemcam,mahli,mardi,navcam,pancam
                                                      ,minites, noFilter])
        filter.menu = menu
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let images = imagesList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as!
        ImCollectionViewCell
        
        downloadImages(image: images.img_src!, imageView: cell.image)
        
        return cell
    }
    
    func getData(url:String){
        
        isLoading = true
        AF.request(url).response {
            response in
            if let data = response.data {
                do{
                    let res = try JSONDecoder().decode(ResponseModel.self, from: data)
                    if let list = res.photos {
                        self.imagesList.append(contentsOf: list)
                        self.isLoading = false
                        DispatchQueue.main.async {
                            self.imagesCollectionView.reloadData()
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func downloadImages(image:String, imageView:UIImageView){
        DispatchQueue.main.async {
            let url = URL(string: image)
            imageView.kf.setImage(with: url)
        }
    }
    
    
}
