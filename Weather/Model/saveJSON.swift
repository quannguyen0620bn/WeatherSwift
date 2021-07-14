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
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    struct city:Codable{
    let name:String
    let coord:coord
    }
    struct coord:Codable{
        let lat:Float
        let lon:Float
    }
    
    

}
