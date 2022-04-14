//
//  CityTableViewCell.swift
//  WeatherAnderson
//
//  Created by sleman on 14.04.22.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func startSetting(text: String){
        label.text = text
    }

}
