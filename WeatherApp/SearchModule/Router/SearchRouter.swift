//
//  SearchRouter.swift
//  WeatherApp
//
//  Created by anita on 11/30/22.
//

import Foundation

final class SearchRouter: SearchRouterInput {

    // MARK: - Properties
    
    weak var view: ModuleTransitionable?
    
    // MARK: - MainRouterInput
    
    func showDetailModule(weather: CurrentWeather) {
        let detailVC = DetailModuleConfigurator().configure(weather: weather)
        view?.push(module: detailVC, animated: true)
    }
    
}
