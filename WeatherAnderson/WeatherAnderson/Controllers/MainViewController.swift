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

    

    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()



    var cityWeatherLocationArray: [CityWeatherLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeather()
        weatherCoreDataArray.count
        searchBar.searchTextField.textColor = .white
        arrayCity = classArrayCity.arrayCity
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let SecondVC = segue.destination as? SecondViewController {
            SecondVC.getLatAndLon(sender as? City)
//            if let indexPath = tableView.indexPathForSelectedRow {
//                DescriptionVC.recipel = recipes[indexPath.row].recipe
//                DescriptionVC.categoryFood = categoryFood
//                DescriptionVC.mainRecipeOrFavorite = true
//            }
        }
    }
    private func loadWeather() {
        if let weather = ServiceWorkWithCoreDate.getWeatherArray(){
            weatherCoreDataArray = weather
            cityTableView.reloadData()
        }
    }


}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showCityArrayOrWeather {
            return 1// cityWeatherLocationArray.count
        } else {
            if filterArrayCity.count != 0 {
                return filterArrayCity.count
            }
            return arrayCity.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if showCityArrayOrWeather {
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherTableViewCell", for: indexPath) as! WeatherTableViewCell
            cell.isHidden = false
            //  let weather = cityWeatherLocationArray[indexPath.row]

            return cell
        } else {
            var city: City!
            let cell = tableView.dequeueReusableCell(withIdentifier: "cityTableViewCell", for: indexPath) as! CityTableViewCell
            if filterArrayCity.count != 0 {
                city = filterArrayCity[indexPath.row]
            } else {
                city = arrayCity[indexPath.row]
            }
            cell.startSetting(text: city.name)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var city: City!
        if !filterArrayCity.isEmpty {
            city = filterArrayCity[indexPath.row]
        } else {
            city = arrayCity[indexPath.row]
        }
        performSegue(withIdentifier: "segueCell", sender: city)
    }


}


// работа с получением координат
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let getMyCity = City("Моя локация", longitude, latitude)
        performSegue(withIdentifier: "segueCell", sender: getMyCity)
    }
    func locationManager(_: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        print("нет локации")
        performSegue(withIdentifier: "segueCell", sender: nil)
    }
}


// поиск по городам
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchBar.showsCancelButton = true
            showCityArrayOrWeather = false
            filterArrayCity = arrayCity.filter({ (item) -> Bool in
                return item.name.lowercased().contains(searchText.lowercased())
            })
        } else {
            searchBar.showsCancelButton = false
            showCityArrayOrWeather = true
        }
        cityTableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        showCityArrayOrWeather = false
        cityTableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        showCityArrayOrWeather = true
        cityTableView.reloadData()
    }
}
