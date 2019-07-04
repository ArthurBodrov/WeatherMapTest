//
//  NetworkingService.swift
//  WeatherMapText
//
//  Created by  Arthur Bodrov on 03/07/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkingService: NSObject {
   
    var cities: [City] = []
    var delegate: Delegate?
    
    func downloadForecast(completed: @escaping () -> ()) {
        Alamofire.request(fullURL).responseJSON { (response) in
            let result = response.result
            let json = JSON(result.value)

            result.ifSuccess { 
                guard let value = self.delegate?.passingValue() else { return }
                for i in 0...value {
                    let name = json["list"][i]["name"].stringValue
                    let temp = json["list"][i]["main"]["temp"].doubleValue
                    let latitude = json["list"][i]["coord"]["lat"].doubleValue
                    let longitude = json["list"][i]["coord"]["lon"].doubleValue
                    self.cities.append(City(name: name, temp: Int(temp), latitude: latitude, longitude: longitude))
                }
            }
            
            result.ifFailure {
                print("API error")
            }
            
            completed()
        }
    }
}
