//
//  DataFetcherService.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation

final class DataFetcherService {

private let apiKey = "&appid=bc09970cb87005d86c068ee8f8b88dde"
private let baseURL = "https://api.openweathermap.org/data/2.5/"
    
    private enum Units {
       static let metric = "&units=metric"
       static let imperial = "&units=imperial"
    }
var dataFetcher: DataFetcher

init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
    self.dataFetcher = dataFetcher
}


    func searchCoordinates(latitude: Double, longitude: Double, comletion: @escaping (Result<CurrentWeather?, Error>) -> Void) {
        let lat = "lat=\(latitude)"
        let lon = "lon=\(longitude)"
        let urlSearch = String(baseURL+"weather?"+lat+"&"+lon+apiKey+Units.metric)
        dataFetcher.fetchGenericJSONData(urlString: urlSearch, response: comletion)
    
    }
    
    func forecast(latitude: Double, longitude: Double, completion: @escaping(Result<Forecast?, Error>) -> Void) {
        let lat = "lat=\(latitude)"
        let lon = "lon=\(longitude)"
        let urlSearch = String(baseURL+"forecast?"+lat+"&"+lon+apiKey+Units.metric)
        dataFetcher.fetchGenericJSONData(urlString: urlSearch, response: completion)
    }
    
}
