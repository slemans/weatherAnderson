//
//  ReloadTableWeatherMainView.swift
//  WeatherAnderson
//
//  Created by sleman on 3.05.22.
//

import UIKit

extension MainViewController: ReloadTableWeather {
    func reloadTableView() {
        myLocationOrNo = false
        showOrDisappearSearchBarOneSelect()
        loadWeather()
    }
}
