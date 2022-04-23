//
//  TableViewMainTableViewCell.swift
//  WeatherAnderson
//
//  Created by sleman on 7.04.22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {


    @IBOutlet weak var cityWeatherLb: UILabel!
    @IBOutlet weak var fonCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fetchAndPutUI(_ weather: WeatherCoreData){
        cityWeatherLb.text = weather.name
        fonCell.image = UIImage(named: weather.background!)
    }

}
