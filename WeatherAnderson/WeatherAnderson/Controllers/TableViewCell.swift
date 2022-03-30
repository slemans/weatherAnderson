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

    func fetchDaily(forWeather weatherDaily: Daily?) {
        guard let weatherDaily = weatherDaily else { return }
        imageIcon.image = UIImage(named: weatherDaily.weather.first!.systemIconNameString)

        dayLb.text = getDateNow(daily: weatherDaily.dt)
        temperatureLb.text = weatherDaily.temp.temperatureStringMinMax
    }

    func getDateNow(daily: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(daily))
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru-RUS")
        let dateNew = date as Date
        let weekday = dateFormater.weekdaySymbols[Calendar.current.component(.weekday, from: dateNew) - 1].firstUppercased
        return weekday
    }

}
