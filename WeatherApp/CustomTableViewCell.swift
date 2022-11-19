//
//  CustomTableViewCell.swift
//  WeatherApp
//
//  Created by Guillem on 14/11/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var lblHour: UILabel!
    @IBOutlet var forecastImage: UIImageView!
    @IBOutlet var forecastTempMin: UILabel!
    @IBOutlet var forecastTempMax: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
