//
//  DetailViewPresenter.swift
//  WeatherApp
//
//  Created by anita on 11/26/22.
//

import Foundation

final class DetailViewPresenter: DetailViewOutput {
    
    //MARK: - Properties
    
    weak var view: DetailViewInput?
    var weather: CurrentWeather
    
    //MARK: - Initialization
    
    required init(weather: CurrentWeather) {
        self.weather = weather
        self.view?.reloadData()
    }
}
