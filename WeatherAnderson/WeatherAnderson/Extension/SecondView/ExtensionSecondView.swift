//
//  ExtensionSecondView.swift
//  WeatherAnderson
//
//  Created by sleman on 28.04.22.
//

import UIKit

extension SecondViewController {
    
    // заполняем UI элементы ViewController
     func fillWetherLocal(weather: CityWeatherLocation) {
        temperatureLabelMain.text = weather.temperature
        iconMainWether.image = UIImage(named: weather.current.weather.first!.systemIconNameString)
        descriptionWeatherLabelMain.text = weather.current.weather.first?.newDescription.firstUppercased
        dayWetherLabel.text = serviceWorkWithTime.getDateNow(daily: weather.dt).0
        timeWetherLabel.text = serviceWorkWithTime.getDateNow(daily: weather.dt).1
        feelLike.text = weather.current.feelString
        pressureLb.text = weather.current.pressureString
        cloudsLb.text = weather.current.cloudsString
        visibilityLb.text = weather.current.visibilityString
        humidity.text = weather.current.humidityString
        sunUpLb.text = serviceWorkWithTime.getSunTime(time: weather.current.sunrise, type: true)
        sunDownLb.text = serviceWorkWithTime.getSunTime(time: weather.current.sunset, type: false)
    }
    
    // все стартовыенастройки ViewController
    func startSetting() {
        if demoWeather {
            stackActivity.isHidden = true
            collectionMain.isHidden = true
            mainStackFirst.isHidden = true
            stackError.isHidden = false
        }
        if !fullViewOrModal {
            closeViewBt.setImage(UIImage(systemName: "clear", withConfiguration: .none), for: .normal)
        }
        saveWeatherButton.isHidden = fullViewOrModal
        stackActivity.alpha = 0.9
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .white
        temperatureStackView.addRightBorderWithColor(color: .white, width: 1)
        stackViewForecast.addBottomBorderWithColor(color: .white, width: 1)
        stackViewCollectionViewTwo.addBottomBorderWithColor(color: .white, width: 1)
        stackViewLast.addBottomBorderWithColor(color: .white, width: 1)
    }
    

    
}
