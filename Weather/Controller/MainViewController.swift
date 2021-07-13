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
    
    @IBOutlet weak var SubView: UIView!
    
    var  weatherManager = WeatherManager()
    var location = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        SubView.layer.cornerRadius = 50
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
            self.tempLabel.text = String(format: "%.f",WeatherData.temp)
            self.cityLabel.text = WeatherData.name
            self.iconWeather.image = UIImage(systemName: WeatherData.conditionID)
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
