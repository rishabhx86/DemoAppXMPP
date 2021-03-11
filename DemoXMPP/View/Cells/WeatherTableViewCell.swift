//
//  WeatherTableViewCell.swift
//  DemoXMPP
//
//  Created by rishabh trivedi on 11/03/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLbl: UILabel!
    @IBOutlet weak var wetherLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(data: WeatherDataViewModel){
        cityNameLbl.text = data.cityName
        wetherLbl.text = String(format: "%.2f",data.temp ?? 0.0)
    }
    func displayLocalData(data: WeatherDetail) {
        cityNameLbl.text = data.city_name
        wetherLbl.text = String(format: "%.2f", data.temp)
    }
}
