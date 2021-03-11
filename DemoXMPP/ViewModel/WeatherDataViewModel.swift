//
//  WeatherDataViewModel.swift
//  DemoXMPP
//
//  Created by rishabh trivedi on 11/03/21.
//

import Foundation

class WeatherDataViewModel: NSObject {

    var cityName: String?
    var temp: Double?
    
   // D I
    
    init(weather:List){
        self.cityName = weather.cityName
        self.temp = weather.main?.temp
    }
    
}
