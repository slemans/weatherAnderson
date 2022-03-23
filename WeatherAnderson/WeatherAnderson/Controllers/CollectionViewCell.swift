//
//  CollectionViewCell.swift
//  WeatherAnderson
//
//  Created by sleman on 23.03.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var temperatureLb: UILabel!
    
//    func fenchHourly(forWeather weatherHourly: Hourly?) {
//        guard let weatherHourly = weatherHourly else { return }
//        iconImage.image = getIcon(hourly: weatherHourly)
//        temperatureLb.text = getTemperature(hourly: weatherHourly)
//    }
//
//    private func getIcon(hourly: Hourly) -> UIImage {
//        let idIcon = hourly.weather[.zero].id
//        let nameIcon = CityWeatherIcon(CityWeatherIcon: idIcon).systemIconNameString
//        let image = UIImage(systemName: nameIcon)!
//        return image
//    }
//
//    private func getTemperature(hourly: Hourly) -> String {
//        return String(hourly.temp)
//    }
}
