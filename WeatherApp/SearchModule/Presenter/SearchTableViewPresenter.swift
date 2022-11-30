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
    
    var router: SearchRouterInput?
    
    required init(view: SearchTableViewInput, dataFetcherService: DataFetcherService) {
        self.view = view
        self.dataFetcherService = dataFetcherService

    }
    
    func loadData(for coord: CLLocationCoordinate2D) {
        dataFetcherService.searchCoordinates(coord: coord) { [weak self] weather in
            guard let self = self else { return }
            self.currentWeather = weather
            self.view?.reloadData()
        }
        
    }
    
    func pushDetailVC(weather: CurrentWeather) {
        router?.showDetailModule(weather: weather)
    }
    
}
