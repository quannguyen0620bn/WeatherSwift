//
//  ViewController.swift
//  Weather
//
//  Created by Quan on 13/07/2021.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UITextFieldDelegate,WeatherDelegate{
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconWeather: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var humidLabel: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var nowLow: UILabel!
    @IBOutlet weak var nowHigh: UILabel!
    
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var SubView: UIView!
    
    @IBOutlet weak var subView1: UIView!
    @IBOutlet weak var subView2: UIView!
    @IBOutlet weak var subView3: UIView!
    @IBOutlet weak var subView4: UIView!
    @IBOutlet weak var subView5: UIView!
    
    @IBOutlet weak var InfoView1: UIView!
    @IBOutlet weak var InfoVIew2: UIView!
    var  weatherManager = WeatherManager()
    var location = CLLocationManager()
    
    
    @IBOutlet weak var Date1: UILabel!
    @IBOutlet weak var Date2: UILabel!
    @IBOutlet weak var Date3: UILabel!
    @IBOutlet weak var Date4: UILabel!
    @IBOutlet weak var Date5: UILabel!

    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var icon3: UIImageView!
    @IBOutlet weak var icon4: UIImageView!
    @IBOutlet weak var icon5: UIImageView!
    
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var temp2: UILabel!
    @IBOutlet weak var temp3: UILabel!
    @IBOutlet weak var temp4: UILabel!
    @IBOutlet weak var temp5: UILabel!
    
    
    var Dates : [UILabel?] = []
    var Icons : [UIImageView?] = []
    var temps : [UILabel?] = []
   
    
    
    @IBOutlet weak var InfoView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Dates = [Date1,Date2,Date3,Date4,Date5]
        Icons = [icon1,icon2,icon3,icon4,icon5]
        temps = [temp1,temp2,temp3,temp4,temp5]
        SubView.layer.cornerRadius = 40
        SubView.backgroundColor = UIColor(white: 1, alpha: 0)
        
        subView1.backgroundColor = UIColor(white: 1, alpha: 0.8)
        subView2.backgroundColor = UIColor(white: 1, alpha: 0.8)
        subView3.backgroundColor = UIColor(white: 1, alpha: 0.8)
        subView4.backgroundColor = UIColor(white: 1, alpha: 0.8)
        subView5.backgroundColor = UIColor(white: 1, alpha: 0.8)
            
        subView1.layer.cornerRadius = 15
        subView2.layer.cornerRadius = 15
        subView3.layer.cornerRadius = 15
        subView4.layer.cornerRadius = 15
        subView5.layer.cornerRadius = 15
        
        
        TopView.layer.cornerRadius = 15
        TopView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        
        InfoView1.backgroundColor = UIColor(white: 1, alpha: 0)
        InfoVIew2.backgroundColor = UIColor(white: 1, alpha: 0)

        
        
        textField.delegate = self
        weatherManager.delegate = self
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.requestLocation()
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text{
            weatherManager.getURLCity(city)
        }
        textField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        weatherManager.getURLCity(textField.text!)
        print(textField.text!)
        textField.endEditing(true)
        return true
        
        
        
    }
    func receiveData(_ WeatherData:WeatherData){
        DispatchQueue.main.async{
            self.cityLabel.text = WeatherData.name
            self.tempLabel.text = String(format: "%.f",WeatherData.list[0].temp)
            
            self.iconWeather.image = UIImage(systemName: WeatherData.list[0].conditionID)
            self.humidLabel.text = String(format: " %.f%%",WeatherData.list[0].humid)
            self.feelLikeLabel.text = String(format: "%.f°C",WeatherData.list[0].feelLike)
            self.nowLow.text = String(format: "%.f°C",WeatherData.list[0].temp_min)
            self.nowHigh.text = String(format: "%.f°C",WeatherData.list[0].temp_max)
            for i in 0...4{
                self.Dates[i]?.text = String(format: "%.f",WeatherData.list[i].temp)
                self.Icons[i]?.image = UIImage(systemName: WeatherData.list[i].conditionID)
                self.temps[i]?.text =   String(format: "%.1f°C",WeatherData.list[i].temp)
                self.Dates[i]?.text = WeatherData.list[i].date
                
            }
           
        }
      
        
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        textField.endEditing(true)
        
        
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        location.startUpdatingLocation()
        
    }
}

extension MainViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.getURLCity(lat, lon)
            
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
