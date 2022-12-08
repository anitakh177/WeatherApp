//
//  MainViewPresenter.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation
import CoreLocation

final class MainViewPresenter: MainViewOutput {
     
    // MARK: - Properties

    var savedWeather = [CurrentWeather]()
    var view: MainViewInput?
    private let dataFetcherService: DataFetcherService
    var currentWeather: CurrentWeather?
    var router: MainRouterInput?
    let locationManager = LocationManager()
  
    // MARK: - Initialization
    
    required init(view: MainViewInput, dataFetcherService: DataFetcherService) {
        self.view = view
        self.dataFetcherService = dataFetcherService
        self.locationManager.delegate = self
        self.locationManager.startUpdating()
    }
    
    // MARK: - Methods
    
    func loadData(lat: Double, long: Double) {
        dataFetcherService.searchCoordinates(latitude: lat, longitude: long) { weather in
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
        let dispatchGroup = DispatchGroup()
        let storage = FavoriteCityStorageService()
       storage.loadCoordinates { [weak self] result in
           switch result {
           case .success(let coord):
              
               coord.forEach { item in
                   dispatchGroup.enter()
                   self?.dataFetcherService.searchCoordinates(latitude: item.lat, longitude: item.lon) { [weak self] weather in
                       self?.savedWeather.append(weather!)
                       dispatchGroup.leave()
                   }
                   
               }
              
               dispatchGroup.notify(queue: .main) {
                   self?.view?.reloadData()
               }
           case .failure(let error):
              print(error)
           }
            
        }
        
    }
    
    func delete(index: Int, indexPath: IndexPath) {
        let storage = FavoriteCityStorageService()
        savedWeather.remove(at: indexPath.row)
        storage.delete(index: index)
    }
    
   
}

extension MainViewPresenter: LocationManagerDelegate {
    
    func showLocationServicesDeniedAlert() {
        router?.showMessageModule(with: "Location Services Disabled", with: "Please enable location services for this app in Settings.")
    }
    
    func didUpdateLocation(lat: Double, long: Double) {
        loadData(lat: lat, long: long)
    }
}
