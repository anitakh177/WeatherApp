//
//  MainViewOutput.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation

protocol MainViewOutput {
    init(view: MainViewInput, dataFetcherService: DataFetcherService)
    func loadData(for text: String)
    var currentWeather: CurrentWeather? { get set }
    var savedCoordinates: [Coord]? { get set }
    var favWeather: [CurrentWeather] { get set }
    func loadData(lat: Double, long: Double)
    func loadCoordinatesFromStorage()
    func pushDetailVC(weather: CurrentWeather)
    func pushSearchVC()
    
}
