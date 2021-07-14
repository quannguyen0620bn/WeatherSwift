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
    let urlWeather = "https://api.openweathermap.org/data/2.5/forecast?appid=9c3401d3b3a3044be3e658c575adc8f3&units=metric&lang=vi"
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
                    if let safeData = data {
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
                
            let name = decodeData.city.name
            var listArray = [WeatherData.list]()
           for i in stride(from: 1, to: 40, by: 8){
            let temp = decodeData.list[i].main.temp
            let id = decodeData.list[i].weather[0].id
            let feelLike = decodeData.list[i].main.feels_like
            let humid = decodeData.list[i].main.humidity
            let temp_min = decodeData.list[i].main.temp_min
            let temp_max = decodeData.list[i].main.temp_max
            let date = convert(i)
            print(date)
            var list = WeatherData.list(temp: temp, id:id, feelLike: feelLike, humid: humid, temp_min: temp_min, temp_max: temp_max,date: date)
            listArray.append(list)
                
           }
            func convert(_ i:Int)->String{
                 let timeResult = decodeData.list[i].dt
                    let date = Date(timeIntervalSince1970: timeResult)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/M"
//                    dateFormatter.timeZone = .current
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                    let localDate = dateFormatter.string(from: date)
                    return localDate
                
            }
                let weather = WeatherData(name: name, list: listArray)
                return weather
            
            
            
    
            
        }
        catch{
            return nil
        }
        
       
        
    }
    
    
    
   


    
    
    
    
    
    
}
