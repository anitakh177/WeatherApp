//
//  SearchTableViewPresenter.swift
//  WeatherApp
//
//  Created by anita on 11/27/22.
//

import Foundation

import CoreLocation

class SearchTableViewPresenter: SearchTableViewOutput {
      
    var view: SearchTableViewInput?
    let dataFetcherService: DataFetcherService
    var currentWeather: CurrentWeather?
    
    required init(view: SearchTableViewInput, dataFetcherService: DataFetcherService) {
        self.view = view
        self.dataFetcherService = dataFetcherService

    }
    
    func loadData(for coord: CLLocationCoordinate2D) {
        dataFetcherService.searchCoordinates(coord: coord) { weather in
            self.currentWeather = weather
            print(self.currentWeather)
    }
    
        
    }
}
