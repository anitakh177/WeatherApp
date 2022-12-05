//
//  MainViewOutput.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation
import CoreLocation

protocol MainViewOutput {
    init(view: MainViewInput, dataFetcherService: DataFetcherService)
    func loadData(for text: String)
    var currentWeather: CurrentWeather? { get set }
    var savedCoordinates: [Coord]? { get set }
    func loadData(for coord: CLLocationCoordinate2D)
    func loadCoordinatesFromStorage()
    func pushDetailVC(weather: CurrentWeather)
    func pushSearchVC()
    
}
