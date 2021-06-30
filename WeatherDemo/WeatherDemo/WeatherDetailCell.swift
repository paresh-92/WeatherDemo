//
//  WeatherDetailCell.swift
//  WeatherDemo
//
//  Created by Paresh Thakkar on 30/06/21.
//

import UIKit

class WeatherDetailCell: UITableViewCell {

    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
