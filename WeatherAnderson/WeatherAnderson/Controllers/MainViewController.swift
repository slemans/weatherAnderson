//
//  MainViewController.swift
//  WeatherAnderson
//
//  Created by sleman on 14.04.22.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let classArrayCity = ArrayCity()
    var arrayCity: [City] = []
    var filterArrayCity: [City] = []
    var showCityArrayOrWeather = true




    var cityWeatherLocationArray: [CityWeatherLocation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.textColor = .white
        arrayCity = classArrayCity.arrayCity
        if CLLocationManager.locationServicesEnabled() {
//            performSegue(withIdentifier: "segueCell", sender: nil)
        }
    }


}

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


}
