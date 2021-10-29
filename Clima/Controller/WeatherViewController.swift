//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManger = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
        
        locationManager.requestLocation()
        
        weatherManger.delegate = self
        searchTextField.delegate = self
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "None")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text ?? "None")
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTextField to get the weather for that city.
        if let city = searchTextField.text {
            weatherManger.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        print(weather.temperatureString)
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
        
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManger.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


