//
//  MainRouterInput.swift
//  WeatherApp
//
//  Created by anita on 11/30/22.
//

import Foundation

protocol MainRouterInput {
    func showPushModule(weather: CurrentWeather)
    func showSearchModule()
}
