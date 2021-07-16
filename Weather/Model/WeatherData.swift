//
//  WeatherData.swift
//  Weather
//
//  Created by Quan on 13/07/2021.
//

import Foundation
import UIKit
struct WeatherData{

    let name:String
    let lat : Float
    let lon : Float
    let clouds:Int
    let visibility:Int
    let description:String
    let windSpeed:Float
    let sunset:String
    let sunrise:String
    
    
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


struct AirPollution{
    var aqi:Int
    let co:Float
    let no:Float
    let no2:Float
    let o3:Float
    let so2:Float
    let pm2_5:Float
    
    
    var LevelAQI:String{
        switch aqi {
        case 1:
            return "Tốt"
        case 2:
            return "Khá tốt"
        case 3:
            return "Trung bình"
        case 4:
            return "Kém"
        case 5:
            return "Rất kém"
            
        default:
            return "Normal"
        }
        }
    
    var colorAQI:UIColor{
        switch aqi {
        case 1:
           return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case 2:
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case 3:
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case 4:
            return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case 5:
            return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        default:
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
    }
    
    var iconAQI:String{
        switch aqi {
        case 1:
           return "aqi.low"
        case 2:
            return "aqi.low"
        case 3:
            return "aqi.medium"
        case 4:
            return "aqi.high"
        case 5:
            return "aqi.high"
        default:
            return "aqi.low"
        }
    }
   
}
