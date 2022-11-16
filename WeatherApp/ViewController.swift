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
    @IBOutlet var labelTemp: UILabel!
    @IBOutlet var labelTempMax: UILabel!
    @IBOutlet var labelTempMinima: UILabel!
    @IBOutlet var tableForecast: UITableView!
    @IBOutlet var weatherImage: UIImageView!
    
    /**
    View lifecycle methods
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableForecast.dataSource = self
        tableForecast.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                
                self.labelTemp.text = response.temp
                self.labelTempMax.text = response.tempMax
                self.labelTempMinima.text = response.tempMin
                
                self.labelCiudad.text = self.cityName
                
                switch response.main {
                case "Rain":
                    self.weatherImage.image = UIImage(systemName: "cloud")
                    break;
                case "Clouds":
                    self.weatherImage.image = UIImage(systemName: "cloud.rain")
                    break;
                case "Clear":
                    self.weatherImage.image = UIImage(systemName: "sun.min")
                    break;
                default:
                    self.weatherImage.image = UIImage(systemName: "cloud")
                    break;
                }
                
            }
            
        }
        
        APIManager.shared.requestForecastForCity(cityName, "es") { (response: [ForecastData]) in
            DispatchQueue.main.async {
                for item in response {
                    print(item.date! + " " + item.weatherDescription! )
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailCities"{
            let citiesDestVC = segue.destination as! CitiesTableViewController
            
            citiesDestVC.nameCityCallback = { nameOfCity in
                self.labelCiudad.text = nameOfCity
                self.cityName = nameOfCity
                self.setupView()
            }
        }
    }
}

