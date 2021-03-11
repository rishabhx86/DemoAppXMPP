//
//  Service.swift
//  MVVMYOUTUBE
//
//  Created by Yogesh Patel on 10/03/19.
//  Copyright © 2019 Yogesh Patel. All rights reserved.
//

import UIKit

class Service: NSObject {

    
    static let shareInstance = Service()
    
    func getAllWeatherData(completion: @escaping([List]?, Error?) -> ()){
        let urlString = "https://api.openweathermap.org/data/2.5/find?lat=26.8467&lon=80.9462&appid=\(infoForKey("kWeatherApiKey") ?? "")"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                do{
                    var arrWeatherData = [List]()
                    let results = try JSONDecoder().decode(WeatherData.self, from: data)
                    for item in results.list ?? []{
                        arrWeatherData.append(item)
                    }
                    completion(arrWeatherData, nil)
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    
}
