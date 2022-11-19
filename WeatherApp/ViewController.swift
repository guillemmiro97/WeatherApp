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
        return forecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! CustomTableViewCell
        
        //
        //intentar mostrar solo la hora, ver como aplicamos formato a la fecha
        //
        guard let  date = forecastData[indexPath.row].date  else { return cell }
        let dateString = String(date.suffix(8).prefix(5))
        
        //espacio en blanco por la mierda de que no se ve el resto.
//        date = ""
        
        cell.lblHour.text = dateString
        cell.forecastTempMin.text = forecastData[indexPath.row].tempMin
        cell.forecastTempMax.text = forecastData[indexPath.row].tempMax
        cell.forecastImage.image = getImage(text: forecastData[indexPath.row].weatherDescription)
        
        
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
                
                self.weatherImage.image = self.getImage(text: response.main!)
                
            }
            
        }
        
        APIManager.shared.requestForecastForCity(cityName, "es") { (response: [ForecastData]) in
            DispatchQueue.main.async {
                
                self.forecastData = response
                self.tableForecast.reloadData()
                
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
    
    func getImage(text: String?) -> UIImage {
        switch text {
        case "Rain":
            return UIImage(systemName: "cloud.rain")!
        case "Clouds":
            return UIImage(systemName: "cloud")!
        case "Clear":
            return UIImage(systemName: "sun.min")!
        default:
            return UIImage(systemName: "cloud")!
        }
    }
}

