//
//  SearchTableViewOutput.swift
//  WeatherApp
//
//  Created by anita on 11/27/22.
//

import Foundation
import CoreLocation

protocol SearchTableViewOutput {
    init(view: SearchTableViewInput, dataFetcherService: DataFetcherService)    
    var currentWeather: CurrentWeather? { get set }
    func loadData(for coord: CLLocationCoordinate2D)
    func pushDetailVC(weather: CurrentWeather) 
     
}
