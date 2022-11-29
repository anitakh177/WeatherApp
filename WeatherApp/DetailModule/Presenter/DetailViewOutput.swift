//
//  DetailViewOutput.swift
//  WeatherApp
//
//  Created by anita on 11/26/22.
//

import Foundation

protocol DetailViewOutput: AnyObject {
    
    var weather: CurrentWeather { get }
    init(weather: CurrentWeather)
    
}
