//
//  WeatherData.swift
//  Weather
//
//  Created by Quan on 13/07/2021.
//

import Foundation
struct WeatherData{
    let temp:Float
    var id:Int
    let name:String
    let feelLike:Float
    let humid:Float
    let temp_min:Float
    let temp_max:Float
    
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

