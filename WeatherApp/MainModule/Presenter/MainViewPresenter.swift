//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation
import CoreLocation

class MainViewPresenter: MainViewOutput {
    var favWeather = [CurrentWeather]()
    var savedCoordinates: [Coord]?
    var view: MainViewInput?
    let dataFetcherService: DataFetcherService
    var currentWeather: CurrentWeather?
    var router: MainRouterInput?
    
    required init(view: MainViewInput, dataFetcherService: DataFetcherService) {
        self.view = view
        self.dataFetcherService = dataFetcherService
    }
    
    func loadData(lat: Double, long: Double) {
        dataFetcherService.searchCoordinates(latitude: lat, longitude: long) { weather in
            self.currentWeather = weather
            self.view?.reloadData()
        }
    }
    
    func loadData(for text: String) {
        dataFetcherService.searchCity(text: text) { weather in
           self.currentWeather = weather
            self.view?.reloadData()
            
        }
    }
    
    func pushDetailVC(weather: CurrentWeather) {
        router?.showPushModule(weather: weather)
    }
   
    func pushSearchVC() {
        router?.showSearchModule()
    }
    
    func loadCoordinatesFromStorage() {
       let storage = FavoriteCityStorageService()
       savedCoordinates = storage.loadCoordinates()
        savedCoordinates?.forEach { item in
            dataFetcherService.searchCoordinates(latitude: item.lat, longitude: item.lon) { [weak self] weather in
                self?.favWeather.append(weather!)
                self?.view?.reloadData()
              
            }
            
        }
        
    }
    
      
}
