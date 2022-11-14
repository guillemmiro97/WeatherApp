//
//  APIManager.swift
//  NetworkDemo
//
//  Created by Alex Tarragó on 1/11/2022.
//  Copyright © 2022 Dribba GmbH. All rights reserved.
//

import Foundation

private let mainBaseURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=f07cca337c89d967b5f2b8dee2884830&q="

private let forecastBaseURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=f07cca337c89d967b5f2b8dee2884830&q="

class APIManager {
    static let shared = APIManager()
    
    init() {}
    
    // Network requests
    func requestWeatherForCity(_ city: String, _ countryCode: String,
                               callback: @escaping (_ data: WeatherData) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(mainBaseURL)\(city),\(countryCode)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask( with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        let data = self.convertToDictionary(text: jsonString)
                        
                        let maindata = data!["main"] as! Dictionary<String,Double>
                        let weather = data!["weather"] as! Dictionary<String,[Dictionary<String,Any>]>
                        print(data)
                        print(weather)
//                        let wd = WeatherData(
//                            main: weather["main"] as! String,
//                            description: weather["description"] as! String,
//                            temp: String(maindata["temp"]!),
//                            tempMax: String(maindata["temp_max"]!),
//                            tempMin: String(maindata["temp_min"]!)
//                        )
//
//                        print(wd)
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    func requestForecastForCity(_ city: String, _ countryCode: String,
                                callback: @escaping (_ data: [ForecastData]) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(forecastBaseURL)\(city),\(countryCode)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        let dataTask = session.dataTask( with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        let data = self.convertToDictionary(text: jsonString)
                        /**
                            TODO: Complete
                         */
                    }
                }
            }
        })
        dataTask.resume()
    }
    
    /**
        Helpers
     */
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
