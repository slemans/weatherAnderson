//
//  TableViewMainTableViewCell.swift
//  WeatherAnderson
//
//  Created by sleman on 7.04.22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionWeatherLb: UILabel!
    @IBOutlet weak var cityWeatherLb: UILabel!
    @IBOutlet weak var temperatureLb: UILabel!
    @IBOutlet weak var fonCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
