//
//  TableViewMainTableViewCell.swift
//  WeatherAnderson
//
//  Created by sleman on 7.04.22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cloudLb: UILabel!
    @IBOutlet weak var temperatureLb: UILabel!
    @IBOutlet weak var cityWeatherLb: UILabel!
    @IBOutlet weak var fonCell: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fetchAndPutUI(_ weather: WeatherCoreData) {
        cityWeatherLb.text = weather.name
        getTemperatureLb(weather.lat, weather.lon)
    }

    private func getTemperatureLb(_ lat: Double, _ lon: Double) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            ServiceApiManager.shared.performRequest(requestType: .coordinate(latitude: lat, longitude: lon)) { [weak self] weatherLocation in
                guard let weatherLocation = weatherLocation else { return }
                DispatchQueue.main.async {
                    self?.fonCell.image = UIImage(named: FuncAllCell.shared.getBackground(item: weatherLocation))
                    self?.cloudLb.text = weatherLocation.current.weather.first?.weatherDescription.firstUppercased
                    self?.temperatureLb.text = weatherLocation.temperature
                }
            }
        }
    }
}


