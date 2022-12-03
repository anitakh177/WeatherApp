//
//  DetailModuleConfigurator.swift
//  WeatherApp
//
//  Created by anita on 11/30/22.
//

import Foundation

final class DetailModuleConfigurator {
    func configure(weather: CurrentWeather) -> DetailViewController {
        let dataFetchService = DataFetcherService()
        let view = DetailViewController()
        let presenter = DetailViewPresenter(weather: weather, dataFetchService: dataFetchService)
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
    
}
