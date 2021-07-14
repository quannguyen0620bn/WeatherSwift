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
    let urlWeather2 = "https://api.openweathermap.org/data/2.5/forecast?appid=9c3401d3b3a3044be3e658c575adc8f3&units=metric"
    func getURLCity(_ city:String){
        let urltemp = "\(urlWeather)&q=\(city)"
        let urltemp2 = "\(urlWeather2)&q=\(city)"
        
        getData(urltemp)
        getData(urltemp2)
    }
    
    
    func getURLCity(_ lat:Double,_ lon:Double){
        let urltemp = "\(urlWeather)&lat=\(lat)&lon=\(lon)"
        getData(urltemp)
    }
    
    func getData(_ url:String){
        print(1)
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let safeData = data{
                    if let weather = ParseJSON(safeData){
                        delegate?.receiveData(weather)
                        print(weather)
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
            let humid = decodeData.main.humidity
            let feelLike = decodeData.main.feels_like
            let nowLow = decodeData.main.temp_min
            let nowHigh = decodeData.main.temp_max
//            let dt1 = decodeData.list[0].dt
//            print(dt1)
            let weather = WeatherData(temp: temp, id: id, name: name, feelLike: feelLike, humid: humid, temp_min: nowLow, temp_max: nowHigh)
            return weather
        }
        catch{
            return nil
        }
        
    }
    
}
