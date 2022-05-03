//
//  OtherExtensionMainView.swift
//  WeatherAnderson
//
//  Created by sleman on 3.05.22.
//

import UIKit

extension MainViewController{
    
    // получаем массив с CoreDate
    func loadWeather() {
        if let weatherArray = ServiceWorkWithCoreDate.shared.getWeatherArray() {
            weatherCoreDataArray = weatherArray
            reloadTable()
        }
    }
    func prepareSegueNextView(_ city: City?) {
        performSegue(withIdentifier: "segueCell", sender: city)
    }
    func reloadTable() {
        cityTableView.reloadData()
    }
    func showOrDisappearSearchBarOneSelect() {
        searchBar.showsCancelButton = false
        showCityArrayOrWeather = true
        view.endEditing(true)
    }
    func showOrDisappearSearchBarTwoSelect() {
        searchBar.showsCancelButton = true
        showCityArrayOrWeather = false
    }
    func startSetting() {
        searchBar.searchTextField.textColor = .white
        arrayCity = classArrayCity.arrayCity
    }
}
