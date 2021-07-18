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
protocol AirPollutionDelegate {
    func AirData(_ AirData:AirPollution)

}

struct WeatherManager{
    var airDelegate:AirPollutionDelegate?
    
    func getLocationURL(_ lat:Float,_ lon :Float){
        let urlAir = "https://api.openweathermap.org/data/2.5/air_pollution?&appid=9c3401d3b3a3044be3e658c575adc8f3"
        let urlAirLoc = "\(urlAir)&lat=\(lat)&lon=\(lon)"
        getDataAir(urlAirLoc)
    }
   
    func getDataAir(_ urlAirLoc:String){
        if let urlAir = URL(string: urlAirLoc){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlAir) { data, response, error in
                if let safeDataAir = data{
                    do{
                        let airData = try JSONDecoder().decode(saveJSONAir.self, from: safeDataAir)
                        let aqi = airData.list[0].main.aqi
                        let co = airData.list[0].components.co
                        let no = airData.list[0].components.no
                        let no2 = airData.list[0].components.no2
                        let o3 = airData.list[0].components.o3
                        let so2 = airData.list[0].components.so2
                        let pm2_5 = airData.list[0].components.pm2_5
                        let airPollution = AirPollution(aqi: aqi, co: co, no: no, no2: no2, o3: o3, so2: so2, pm2_5: pm2_5)
                        airDelegate?.AirData(airPollution)
                    }
                    catch{
                        print(error)
                    }
                    
                    
                }
                else{
                    print(error!)
                }
    
        }
            task.resume()
    }
    }
    
    var delegate : WeatherDelegate?
    let urlWeather = "https://api.openweathermap.org/data/2.5/forecast?appid=9c3401d3b3a3044be3e658c575adc8f3&units=metric&lang=vi"
    func getURLCity(_ city:String){
        let urltemp = "\(urlWeather)&q=\(city)"
        getDataMain(urltemp)
    }
    func getURLCity(_ lat:Double,_ lon:Double){
        let urltemp = "\(urlWeather)&lat=\(lat)&lon=\(lon)"
        print(urltemp)
        getDataMain(urltemp)
    }
    
    
    
    func getDataMain(_ url:String){
        if let url = URL(string: url){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                    if let safeData = data {
                        if let weather = ParseJSONMain(safeData){
                            delegate?.receiveData(weather)
                        }
                    }else{
                        print(error!)
                    }
        }
            task.resume()
        }
    }
    
    func ParseJSONMain(_ safeData:Data)->WeatherData?{
        let decoder = JSONDecoder()
        do{
            
                let decodeData = try decoder.decode(saveJSON.self, from: safeData)
                
            let name = decodeData.city.name
            var listArray = [WeatherData.list]()
            let lat = decodeData.city.coord.lat
            let lon = decodeData.city.coord.lon
            let description = decodeData.list[0].weather.description
            let clouds = decodeData.list[0].clouds.all
            let visibility = decodeData.list[0].visibility
            let windSpeed = decodeData.list[0].wind.speed
            let sunset = decodeData.city.sunset
            let sunrise = decodeData.city.sunrise
            let timezone = decodeData.city.timezone
            let TimeSunset = convertTime(sunset,timezone)
            let TimeSunrise = convertTime(sunrise,timezone)
            
           for i in stride(from: 1, to: 40, by: 8){
            let temp = decodeData.list[i].main.temp
            let id = decodeData.list[i].weather[0].id
            let feelLike = decodeData.list[i].main.feels_like
            let humid = decodeData.list[i].main.humidity
            let temp_min = decodeData.list[i].main.temp_min
            let temp_max = decodeData.list[i].main.temp_max
            let date = convertDay(i,timezone)
            var list = WeatherData.list(temp: temp, id:id, feelLike: feelLike, humid: humid, temp_min: temp_min, temp_max: temp_max,date: date)
            listArray.append(list)
                
           }
            
            func convertDay(_ i:Int,_ timezone:Int)->String{
                 let timeResult = decodeData.list[i].dt
                    let date = Date(timeIntervalSince1970: timeResult)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "dd/M"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
                    let localDate = dateFormatter.string(from: date)
                    return localDate
                
            }
            func convertTime(_ Time:Double,_ timezone:Int)->String{
                 let timeResult = Time
                    let date = Date(timeIntervalSince1970: timeResult)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mm"
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
                    let localDate = dateFormatter.string(from: date)
                    return localDate
            }
            
            let weather = WeatherData(name: name, lat: lat, lon: lon, clouds: clouds, visibility: visibility,description:description , windSpeed:windSpeed , sunset: TimeSunset, sunrise: TimeSunrise, list: listArray)
                return weather
            
        }
        catch{
            return nil
        }
        
       
        
    }

    
    
    
}
