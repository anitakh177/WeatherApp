//
//  MainRouter.swift
//  WeatherApp
//
//  Created by anita on 11/30/22.
//

import Foundation

final class MainRouter: MainRouterInput {
    
    // MARK: - Properties
    weak var view: ModuleTransitionable?
    
    // MARK: - MainRouterInput
    func showPushModule(weather: CurrentWeather) {
        let detailVC = DetailModuleConfigurator().configure(weather: weather)
        view?.push(module: detailVC, animated: true)
    }
    
    func showSearchModule() {
        let searchVC = SearchModuleConfigurator().searchTableConfigurator()
        view?.push(module: searchVC, animated: true)
    }
    
    
  
}
