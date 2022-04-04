//
//  TableViewCell.swift
//  WeatherAnderson
//
//  Created by sleman on 24.03.22.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var temperatureLb: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var dayLb: UILabel!
    
    let serviceWorkWithTime = ServiceWorkWithTime()

    func fetchDaily(forWeather weatherDaily: Daily?) {
        guard let weatherDaily = weatherDaily else { return }
        imageIcon.image = UIImage(named: weatherDaily.weather.first!.systemIconNameString)

        dayLb.text = serviceWorkWithTime.getDatetimeWeak(daily: weatherDaily.dt)
        temperatureLb.text = weatherDaily.temp.temperatureStringMinMax
    }


}
