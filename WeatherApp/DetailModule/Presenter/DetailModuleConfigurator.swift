//
//  DetailModuleConfigurator.swift
//  WeatherApp
//
//  Created by anita on 11/26/22.
//

import Foundation

final class DetailModuleConfigurator {
    
    func configure(weather: CurrentWeather) -> DetailViewController {
        let view = DetailViewController()
        let presenter = DetailViewPresenter(weather: weather)
        
        view.presenter = presenter
        presenter.view = view
        
        return view
    }
}
