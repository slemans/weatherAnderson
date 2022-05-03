//
//  MainViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 14.04.22.
//

import UIKit
import CoreLocation
import CoreData

class MainViewController: UIViewController {

    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    let classArrayCity = ArrayCity()
    var arrayCity: [City] = []
    var filterArrayCity: [City] = []
    var weatherCoreDataArray: [WeatherCoreData] = []
    var showCityArrayOrWeather = true
    var myLocationOrNo = false
    var cityWeatherLocationArray: [CityWeatherLocation] = []


    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        startSetting()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadWeather()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SecondViewController {
            if showCityArrayOrWeather {
                secondVC.modalPresentationStyle = .fullScreen
                secondVC.fullViewOrModal = showCityArrayOrWeather
            } else {
                secondVC.fullViewOrModal = false
            }
            secondVC.myLocation = myLocationOrNo
            secondVC.view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            secondVC.getLatAndLon(sender as? City)
            secondVC.delegate = self
        }
    }
    
}







