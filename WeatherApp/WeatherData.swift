//
//  WeatherData.swift
//  NetworkDemo
//
//  Created by Alex on 1/11/22.
//  Copyright © 2022 Dribba GmbH. All rights reserved.
//

import Foundation

class WeatherData {
    var main: String?
    var description: String?
    var temp: String?
    var tempMax: String?
    var tempMin: String?
    
    init(main: String? = nil, description: String? = nil, temp: String? = nil, tempMax: String? = nil, tempMin: String? = nil) {
        self.main = main
        self.description = description
        self.temp = temp! + " °C"
        self.tempMax = tempMax! + " °C"
        self.tempMin = tempMin! + " °C"
    }
}

class ForecastData {
    var date: String?
    var weatherDescription: String?
    var temp: Double?
    var tempMax: Double?
    var tempMin: Double?
    
    init(date: String? = nil, weatherDescription: String? = nil, temp: Double? = nil, tempMax: Double? = nil, tempMin: Double? = nil) {
        self.date = date
        self.weatherDescription = weatherDescription
        self.temp = temp
        self.tempMax = tempMax
        self.tempMin = tempMin
    }
}
