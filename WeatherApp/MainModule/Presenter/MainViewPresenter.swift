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
    var networkMonitor = NetworkMonitor()
    
    // MARK: - Initialization
    
    required init(view: MainViewInput, dataFetcherService: DataFetcherService) {
        self.view = view
        self.dataFetcherService = dataFetcherService
        self.locationManager.delegate = self
        self.locationManager.startUpdating()
        networkMonitor.startMonitoring()
    }
    
    // MARK: - Methods
    
    func loadData(lat: Double, long: Double) {
        dataFetcherService.searchCoordinates(latitude: lat, longitude: long) { [weak self] weather in
            guard let self = self else { return }
            switch weather {
            case .success(let currentWeather):
                self.currentWeather = currentWeather
                self.view?.reloadData()
                
            case .failure(_):
                break
                
            }
           
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
         guard let self = self else { return }
         switch result {
            case .success(let coord):
            self.savedWeather = []
             coord.forEach { item in
                 dispatchGroup.enter()
                 self.dataFetcherService.searchCoordinates(latitude: item.lat, longitude: item.lon) { [weak self] weather in
                     
                     switch weather {
                     case .success(let currentWeather):
                         if let currentWeather = currentWeather {
                             self?.savedWeather.append(currentWeather)
                         }
                         dispatchGroup.leave()
                         dispatchGroup.notify(queue: .main) {
                             self?.view?.reloadData()
                         }
                     case .failure(let error):
                         print(error.localizedDescription)
                     
                     }
                     
                 }
             }
           
            case .failure(let error):
                    print(error)
                }
                                        
            }
                                        
    }
    
    func delete(indexPath: IndexPath, index: Int) {
         let storage = FavoriteCityStorageService()
        savedWeather.remove(at: indexPath.row)
         storage.delete(index: index)
        
    }
    
    func monitoring() {
        if networkMonitor.isConnected == false  {
            DispatchQueue.main.async {
                self.router?.showMessageModule(with: "No Internet Connection", with: "Please check your access to Internet")
            }
        } else {
            return
        }
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

