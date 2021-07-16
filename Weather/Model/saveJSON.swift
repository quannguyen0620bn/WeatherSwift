//
//  saveJSON.swift
//  Weather
//
//  Created by Quan on 13/07/2021.
//

import Foundation
struct saveJSON:Codable{
    let city:city
    let list:[list]
    
    
    struct list:Codable{
        let main:main
        let weather:[weather]
        let dt_txt:String
        let dt:Double
        let clouds:clouds
        let visibility:Int
        let wind:wind
        
    }
    struct main:Codable {
        var temp:Float
        let feels_like:Float
        let temp_min:Float
        let temp_max:Float
        let humidity:Float
        
    }
    struct weather:Codable{
        let id:Int
        let description:String
    }
    struct clouds:Codable{
        let all :Int
    }
    struct wind:Codable{
        let speed:Float
    }
    
    
    struct city:Codable{
        let name:String
        let sunrise:Double
        let sunset:Double
        let timezone:Int
    let coord:coord
    }
    struct coord:Codable{
        let lat:Float
        let lon:Float
    }
    
  

}
struct saveJSONAir:Codable {
    let list: [list]
    
    
    
    
    struct list:Codable{
        let main:main
        let components:components
    }
    
    struct components:Codable{
        let co:Float
        let no:Float
        let no2:Float
        let o3:Float
        let so2:Float
        let pm2_5:Float
        
    }
    
    
    struct main:Codable {
        var aqi:Int
    }
}
