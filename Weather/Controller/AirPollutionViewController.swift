//
//  AirPollutionViewController.swift
//  Weather
//
//  Created by Quan on 15/07/2021.
//

import UIKit

class AirPollutionViewController: UIViewController,AirPollutionDelegate{
    
    
    
    
    @IBOutlet var background: UIView!
    
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var sttView1: UIView!
    @IBOutlet weak var sttView2: UIView!
    @IBOutlet weak var sttView3: UIView!
    @IBOutlet weak var sttView4: UIView!
    @IBOutlet weak var sttView5: UIView!
    @IBOutlet weak var sttView6: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var aqiLevel: UILabel!
    @IBOutlet weak var aqiIcon: UIImageView!
    
    @IBOutlet weak var coLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var no2Label: UILabel!
    @IBOutlet weak var o3Label: UILabel!
    @IBOutlet weak var so2Label: UILabel!
    @IBOutlet weak var pm2_5Label: UILabel!
    
    var AirManager = WeatherManager()
    var lat: Float = 0.0
    var lon: Float = 0.0
    var cityName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        

        AirManager.airDelegate = self
        AirManager.getLocationURL(lat, lon)
        topView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        topView.layer.cornerRadius = 15
        sttView1.backgroundColor = UIColor(white: 1, alpha: 0.8)
        sttView2.backgroundColor = UIColor(white: 1, alpha: 0.8)
        sttView3.backgroundColor = UIColor(white: 1, alpha: 0.8)
        sttView4.backgroundColor = UIColor(white: 1, alpha: 0.8)
        sttView5.backgroundColor = UIColor(white: 1, alpha: 0.8)
        sttView6.backgroundColor = UIColor(white: 1, alpha: 0.8)
        sttView1.layer.cornerRadius = 15
        sttView2.layer.cornerRadius = 15
        sttView3.layer.cornerRadius = 15
        sttView4.layer.cornerRadius = 15
        sttView5.layer.cornerRadius = 15
        sttView6.layer.cornerRadius = 15
        backButton.layer.cornerRadius = 20
        
        cityLabel.text = cityName

    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func AirData(_ AirData: AirPollution) {
        DispatchQueue.main.async {
            self.coLabel.text = String(format: "%.2f μg/m3", AirData.co)
            self.noLabel.text = String(format: "%.2f μg/m3", AirData.no)
            self.no2Label.text = String(format: "%.2f μg/m3", AirData.no2)
            self.o3Label.text = String(format: "%.2f μg/m3", AirData.o3)
            self.so2Label.text = String(format: "%.2f μg/m3", AirData.so2)
            self.pm2_5Label.text = String(format: "%.2f μg/m3", AirData.pm2_5)
            self.aqiIcon.image = UIImage(systemName: AirData.iconAQI)
            self.background.backgroundColor = AirData.colorAQI
            self.aqiLevel.text = AirData.LevelAQI
           
            
            
            
        }
        
        
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
