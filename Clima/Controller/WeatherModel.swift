//
//  WeatherModel.swift
//  Clima
//
//  Created by He Liu on 2021-10-29.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var aProperty: Int {
        return 2 + 5
    }
    
    var conditionName: String {
        switch conditionId {
        case 200..<300:
            return "cloud.bolt"
        case 300..<400:
            return "cloud.drizzle"
        case 500..<600:
            return "cloud.rain"
        case 600..<700:
            return "cloud.snow"
        case 700..<800:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801..<900:
            return "cloud"
        default:
            return "sun.max.fill"
        }
    
    
    }
}
