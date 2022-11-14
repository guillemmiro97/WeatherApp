//
//  ViewController.swift
//  NetworkDemo
//
//  Created by Alex Tarragó on 01/11/2022.
//  Copyright © 2022 Dribba GmbH. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cityName: String = "Barcelona"
    var forecastData: [ForecastData] = []
    
    /**
    View lifecycle methods
     */
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! CustomTableViewCell
        
        return cell
    }
    
    /**
    Helpers
     */
    func setupView() {
        APIManager.shared.requestWeatherForCity(cityName, "es") { ( response: WeatherData) in
            DispatchQueue.main.async {
                /**
                    Update Main Weather Data
                 */
            }
        }
        
        APIManager.shared.requestForecastForCity(cityName, "es") { data in
            DispatchQueue.main.async {
                /**
                    Update Table View Data
                 */
            }
        }
    }
}

