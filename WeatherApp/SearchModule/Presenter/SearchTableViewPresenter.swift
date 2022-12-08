//
//  SearchTableViewPresenter.swift
//  WeatherApp
//
//  Created by anita on 11/27/22.
//

import Foundation

import CoreLocation

final class SearchTableViewPresenter: SearchTableViewOutput {
    
    // MARK: - Properties
   
    var view: SearchTableViewInput?
    var router: SearchRouterInput?
    let dataFetcherService: DataFetcherService
    var currentWeather: CurrentWeather?
    var locations: [Location]?
    private let locationManager = LocationManager()
    
    // MARK: - Initialization
    
    required init(view: SearchTableViewInput, dataFetcherService: DataFetcherService) {
        self.view = view
        self.dataFetcherService = dataFetcherService

    }
    
    // MARK: - Methods
    
    func loadData(for lat: Double, long: Double) {
        dataFetcherService.searchCoordinates(latitude: lat, longitude: long) { [weak self] weather in
            guard let self = self else { return }
            self.currentWeather = weather
            self.view?.reloadData()
        }
        
    }
    
    func pushDetailVC(weather: CurrentWeather) {
        router?.showDetailModule(weather: weather)
    }
    
    func searchLocation(for text: String) {
        self.locations = []
        locationManager.findLocations(with: text) { [weak self] location in
                DispatchQueue.main.async {
                    self?.locations! += location
                    self?.view?.reloadData()

            }
        }
    }
    
}
