//
//  WeatherDetailVC.swift
//  WeatherDemo
//
//  Created by Paresh Thakkar on 30/06/21.
//

import UIKit

class WeatherDetailVC: UIViewController {

    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblFeelsLike: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblTop: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    var temp = String()
    var humadity = String()
    var image = UIImage()
    var tempDescription = String()
    var pressure = String()
    var feelslike = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTop.text = tempDescription
        self.imgWeather.image = image
        self.lblDesc.text = tempDescription
        self.lblHumidity.text = "Humidity : " + humadity
        self.lblTemp.text = "Temperature : " + temp
        self.lblPressure.text = "Pressure : " + pressure
        self.lblFeelsLike.text = "Feels Like : " + feelslike
    }

    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
