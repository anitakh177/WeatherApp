//
//  DataFetcherService.swift
//  WeatherApp
//
//  Created by anita on 11/24/22.
//

import Foundation
import CoreLocation

final class DataFetcherService {

private let apiKey = "&appid=bc09970cb87005d86c068ee8f8b88dde"
private let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    
    private enum Units {
       static let metric = "&units=metric"
       static let imperial = "&units=imperial"
    }
var dataFetcher: DataFetcher

init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
    self.dataFetcher = dataFetcher
}


func searchCity(text: String, completion: @escaping(CurrentWeather?) -> Void) {
    let encodedText = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    let urlSearch = String(baseURL+"q="+encodedText+apiKey+Units.metric)
        dataFetcher.fetchGenericJSONData(urlString: urlSearch, response: completion)
    }
    
    func searchCoordinates(coord: CLLocationCoordinate2D, comletion: @escaping(CurrentWeather?) -> Void) {
        let lat = "lat=\(coord.latitude)"
        let lon = "lon=\(coord.longitude)"
        let urlSearch = String(baseURL+lat+"&"+lon+apiKey+Units.metric)
        dataFetcher.fetchGenericJSONData(urlString: urlSearch, response: comletion)
        
    }
    
}
