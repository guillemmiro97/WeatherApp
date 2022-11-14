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
    
    
    @IBOutlet var labelCiudad: UILabel!
    @IBOutlet var labelTempMax: UILabel!
    @IBOutlet var labelTempMinima: UILabel!
    @IBOutlet var tableForecast: UITableView!
    
    /**
    View lifecycle methods
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableForecast.dataSource = self
        tableForecast.delegate = self
        
        setupView()
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
                
                self.labelTempMax.text = response.tempMax
                self.labelTempMinima.text = response.tempMin
                
                self.labelCiudad.text = self.cityName
                
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

