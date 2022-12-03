//
//  DetailViewInput.swift
//  WeatherApp
//
//  Created by anita on 11/26/22.
//

import Foundation

protocol DetailViewInput: AnyObject {
    func updateForecast(_ model: [ForecastViewModel])
    func reloadData()
}
