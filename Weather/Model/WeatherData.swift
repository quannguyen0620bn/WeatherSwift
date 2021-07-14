//
//  WeatherData.swift
//  Weather
//
//  Created by Quan on 13/07/2021.
//

import Foundation
struct WeatherData{

    let name:String
    
    let list:[list]
    struct list{
            var temp:Float
            var id:Int
            let feelLike:Float
            let humid:Float
            let temp_min:Float
            let temp_max:Float
            let date:String
        
            var conditionID:String{
                switch id {
                case 200...232:
                    return "cloud.bolt"
                case 300...321:
                    return "cloud.drizzle"
                case 500...531:
                    return "cloud.rain"
                case 600...632:
                    return "cloud.snow"
                case 701...800:
                    return "cloud.fog"
                case 800:
                    return "sun.max"
                default:
                    return "cloud"
            }
        
            }
    }
    
    
    
    
    
    

}

