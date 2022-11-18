//
//  File.swift
//  NasaRoverProject
//
//  Created by Zeynep Baştuğ on 14.11.2022.
//

import Foundation

class ResponseModel:Codable {
    
    var photos:[Photo]?
}

class Photo:Codable {
    
    var id:Int?
    var camera:Camera?
    var img_src:String?
    var earth_date:String?
    var rover:Rover?
    
}

class Camera:Codable {
    
    var id:Int?
    var name:String?
}

class Rover:Codable {
    
    var id:Int?
    var name:String?
    var landing_date:String?
    var launch_date:String?
    var status:String?

}





