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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
