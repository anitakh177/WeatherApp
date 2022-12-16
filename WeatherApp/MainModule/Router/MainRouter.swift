//
//  MainRouter.swift
//  WeatherApp
//
//  Created by anita on 11/30/22.
//

import Foundation
import UIKit

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
    
    func showMessageModule(with title: String, with message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        view?.presentModule(alertController, animated: true, completion: nil)
    }
}
