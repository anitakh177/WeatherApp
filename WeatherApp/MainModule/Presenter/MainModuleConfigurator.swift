//
//  Configurator.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation
import UIKit

final class MainModuleConfigurator {
    
    func configureMainModule() -> UIViewController {
      let view = MainViewController()
      let dataFetcherService = DataFetcherService()
      let presenter = MainViewPresenter(view: view, dataFetcherService: dataFetcherService)
        view.presenter = presenter
        
        return view
    }
    
    func searchTableConfigurator() -> UITableViewController {
        let view = LocationSearchTable()
        let dataFetcherService = DataFetcherService()
        let presenter = MainViewPresenter(view: view, dataFetcherService: dataFetcherService)
        view.presenter = presenter
        
        return view
    }
}
