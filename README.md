# NasaRoverApp
Displaying NASA Rover photos and filtering them according to cameras


This app is developed with Swift programming language.

**Requirements**

1- Requesting the API, returned images are displayed in a CollectionView with pagination (infinite scroll).

2- There are 3 tabs in one tabbar which are Curiosity, Opportunity, Spirit tools. Each Tab contains related photos. 

3- According to the camera by filtering with the filter button on the top right for each vehicle.

4- When one of the pictures is touched, a pop-up opens, and if the picture at the top is at the bottom, the date it was taken, the name of the vehicle, the camera from which it was taken, the mission status of the vehicle, the launch date of the vehicle and the landing date information is displayed.

**API**

This api used for data : https://api.nasa.gov/index.html#browseAPI

**Application**

Download and run the application. Tap one of the tab bars, related images will display. Tap top right button for filtering these images according to cameras. If you want to increase or decrease Martian sol range, use top left stepper (If there is no image on the screen, try this button).

**External Libraries**

Alamofire: https://github.com/Alamofire/Alamofire
Kingfisher: https://github.com/onevcat/Kingfisher

**Supported Devices**

This application is developed with Swift programming language.
Tests are done with Iphone 13 simulator.

**ScreenShots**

![Simulator Screen Shot - iPhone 13 - 2022-11-18 at 23 01 38](https://user-images.githubusercontent.com/102912212/202792628-3e24ab84-cc80-4003-b11c-64e37662a163.png)

![Simulator Screen Shot - iPhone 13 - 2022-11-18 at 23 01 45](https://user-images.githubusercontent.com/102912212/202792655-ee3db621-4efe-4239-8b0b-1c34ee1aae53.png)
