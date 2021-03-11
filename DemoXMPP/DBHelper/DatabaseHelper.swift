//
//  DatabaseHelper.swift
//  PizzaYum
//
//  Created by rishabh trivedi on 02/M/19 Anno Domini.
//  Copyright © 2019 rishabhtrivedi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DatabaseHelper{
    static var shareInstance = DatabaseHelper()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(object: WeatherCoreData) {
        let weather = NSEntityDescription.insertNewObject(forEntityName: "WeatherDetail", into: context!) as! WeatherDetail
        
        weather.city_name = object.cityName
        weather.temp = object.weather
        
        do {
            try context?.save()
        } catch {
            print("something went wrong")
        }
    }
    
    func  getweather() -> [WeatherDetail] {
        var weather = [WeatherDetail]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WeatherDetail")
        do{
            weather = try context?.fetch(fetchRequest) as! [WeatherDetail]
        } catch {
            print("cannot fetch")
        }
        return weather
    }
    
    
}
    
