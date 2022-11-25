//
//  Configurator.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation
import UIKit

final class Configurator {
    
    func configureMainModule() -> UIViewController {
      let view = MainViewController()
      let dataFetcherService = DataFetcherService()
      let presenter = MainViewPresenter(view: view, dataFetcherService: dataFetcherService)
        view.presenter = presenter
        
        return view
    }
}
