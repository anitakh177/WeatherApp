//
//  DetailViewOutput.swift
//  WeatherApp
//
//  Created by anita on 11/26/22.
//

import Foundation

protocol DetailViewOutput: AnyObject {
    func loadForecast()
    var weather: CurrentWeather { get }
    var forecast: Forecast? { get }
    func save()
    init(weather: CurrentWeather, dataFetchService: DataFetcherService)
    
}
