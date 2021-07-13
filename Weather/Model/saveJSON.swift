//
//  saveJSON.swift
//  Weather
//
//  Created by Quan on 13/07/2021.
//

import Foundation
struct saveJSON:Codable{
    let coord:coord
    let main:main
    let weather:[weather]
    let name:String
    
}
struct coord:Codable{
    let lon:Float
    let lat:Float
}
struct main:Codable{
    let temp:Float
    let feels_like:Float
    let humidity:Float
    let temp_min:Float
    let temp_max:Float
}
struct weather:Codable{
    let id:Int
}
