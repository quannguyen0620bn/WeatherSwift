//
//  WeatherManager.swift
//  Weather
//
//  Created by Quan on 13/07/2021.
//

import Foundation

protocol WeatherDelegate {
    func receiveData(_ weather:WeatherData)
}


struct WeatherManager{
    var delegate : WeatherDelegate?
    let urlWeather = "https://api.openweathermap.org/data/2.5/weather?appid=9c3401d3b3a3044be3e658c575adc8f3&units=metric&lang=vi"
    func getURLCity(_ city:String){
        let urltemp = "\(urlWeather)&q=\(city)"
        getData(urltemp)
    }
    
    func getURLCity(_ lat:Double,_ lon:Double){
        let urltemp = "\(urlWeather)&lat=\(lat)&lon=\(lon)"
        getData(urltemp)
    }
    
    func getData(_ url:String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let safeData = data{
                    if let weather = ParseJSON(safeData){
                        delegate?.receiveData(weather)
                    }
                }else{
                    print(error!)
                }
        }
            task.resume()
        }
    }
    func ParseJSON(_ safeData:Data)->WeatherData?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(saveJSON.self, from: safeData)
            let temp = decodeData.main.temp
            let id = decodeData.weather[0].id
            let name = decodeData.name
            let weather = WeatherData(temp: temp, id: id, name: name)
            return weather
        }
        catch{
            return nil
        }
        
    }
    
}
