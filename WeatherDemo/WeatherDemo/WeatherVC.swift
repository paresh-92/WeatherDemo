//
//  WeatherVC.swift
//  WeatherDemo
//
//  Created by Paresh Thakkar on 30/06/21.
//

import UIKit
import SDWebImage

class WeatherVC: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tblWeather: UITableView!
    
    var mainDict : [String:Any] = [:]
    var dailyArray : [Any] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callWeatherAPI()
        // Do any additional setup after loading the view.
    }
}
extension WeatherVC : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblWeather.dequeueReusableCell(withIdentifier: "WeatherDetailCell", for: indexPath) as! WeatherDetailCell
        let dct = dailyArray[indexPath.row] as! [String:Any]
        let humidity = dct["humidity"] as! Int
        cell.lblHumidity.text = "\(humidity)"
        let weatherArr = dct["weather"] as! [[String:Any]]
        let dct1 = weatherArr[0]
        cell.lblDesc.text = (dct1["description"] as! String)
        let tempDic = dct["temp"] as! [String:Any]
        let dayTemp = tempDic["day"] as! NSNumber
        cell.lblTemp.text = "\(dayTemp)"
        let icon = dct1["icon"] as! String
        let url = "http://openweathermap.org/img/wn/" + icon + "@2x.png"
        cell.imgWeather.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "WeatherDetailVC") as! WeatherDetailVC
        let cell = tblWeather.cellForRow(at: indexPath) as! WeatherDetailCell
        let dct = dailyArray[indexPath.row] as! [String:Any]
        let pressure = dct["pressure"] as! NSNumber
        let feelslike = dct["feels_like"] as! [String:Any]
        let day = feelslike["day"] as! NSNumber
        vc.tempDescription = cell.lblDesc.text ?? ""
        vc.humadity = cell.lblHumidity.text ?? ""
        vc.image = cell.imgWeather.image!
        vc.temp = cell.lblTemp.text ?? ""
        vc.pressure = "\(pressure)"
        vc.feelslike = "\(day)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension WeatherVC
{
    func callWeatherAPI()
    {
        self.activityIndicator.startAnimating()
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=39.96698&lon=-75.17210&exclude=current,minutely,hourly,daily,alerts&appid=5331402505723916a63db7fe55c0f171")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    self.mainDict = json
                    let key = self.mainDict.keys
                    if key.contains("daily")
                    {
                        self.dailyArray = self.mainDict["daily"] as! [Any]
                        DispatchQueue.main.async {
                            self.tblWeather.reloadData()
                        }
                        
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
    }
}
