//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation
import CoreLocation

class MainViewPresenter: MainViewOutput {
      
    var view: MainViewInput?
    let dataFetcherService: DataFetcherService
    var currentWeather: CurrentWeather?
    
    required init(view: MainViewInput, dataFetcherService: DataFetcherService) {
        self.view = view
        self.dataFetcherService = dataFetcherService

    }
    
    func loadData(for coord: CLLocationCoordinate2D) {
        dataFetcherService.searchCoordinates(coord: coord) { weather in
            self.currentWeather = weather
            print(self.currentWeather)
            self.view?.reloadData()
        }
    }
    
    func loadData(for text: String) {
        dataFetcherService.searchCity(text: text) { weather in
           self.currentWeather = weather
            print(self.currentWeather)
            self.view?.reloadData()
            
        }
        
    }
}