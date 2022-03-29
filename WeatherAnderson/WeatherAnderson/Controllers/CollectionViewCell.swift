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
    
    func fetchHourly(forWeather weatherHourly: Current?) {
        guard let weatherHourly = weatherHourly else { return }
        iconImage.image = UIImage(named: weatherHourly.weather.first!.systemIconNameString)
        temperatureLb.text = weatherHourly.temperatureString
    }

}
