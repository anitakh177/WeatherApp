//
//  SearchTableViewOutput.swift
//  WeatherApp
//
//  Created by anita on 11/27/22.
//

import Foundation

protocol SearchTableViewOutput {
    init(view: SearchTableViewInput, dataFetcherService: DataFetcherService)    
    var currentWeather: CurrentWeather? { get set }
    func loadData(for lat: Double, long: Double)
    func pushDetailVC(weather: CurrentWeather) 
     
}
