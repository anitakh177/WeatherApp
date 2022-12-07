//
//  MainViewOutput.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation

protocol MainViewOutput {
    init(view: MainViewInput, dataFetcherService: DataFetcherService)
    var currentWeather: CurrentWeather? { get set }
    var savedWeather: [CurrentWeather] { get set }
    func loadData(lat: Double, long: Double)
    func loadCoordinatesFromStorage()
    func pushDetailVC(weather: CurrentWeather)
    func pushSearchVC()
    func delete(index: Int, indexPath: IndexPath)
    
}
