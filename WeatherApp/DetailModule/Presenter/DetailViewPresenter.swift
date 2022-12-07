//
//  DetailViewPresenter.swift
//  WeatherApp
//
//  Created by anita on 11/26/22.
//

import Foundation
import CoreLocation

final class DetailViewPresenter: DetailViewOutput {
   
    
    
    //MARK: - Properties
    
    let dataFetcherService: DataFetcherService
    var view: DetailViewInput?
    var weather: CurrentWeather
    var forecast: Forecast?
    var forecastViewModel = [ForecastViewModel]()
    
    //MARK: - Initialization
    
    required init(weather: CurrentWeather, dataFetchService: DataFetcherService) {
        self.weather = weather
        self.dataFetcherService = dataFetchService
    }
    
    func loadForecast() {
        dataFetcherService.forecast(latitude: weather.coord.lat, longitude: weather.coord.lon) { [weak self] forecast in
            self?.forecast = forecast
            self?.view?.updateForecast(self!.getDailyForecast(forecast: forecast!))
          
        }
           
    }
    
    func getDailyForecast(forecast: Forecast) -> [ForecastViewModel] {
        
        let dateConverter = DateConverter(timezone: (forecast.city.timezone))
    
        var minTemperature = [String: Double]()
        var maxTemperature = [String: Double]()
        var firstDate = [String: Date]()
        var firstIcon = [String: Int]()
       
        for item in forecast.list {
            let dayOfWeek = dateConverter.convertDateFromUTC(string: item.dtTxt).getDayOfWeek()
            minTemperature.merge([dayOfWeek: item.main.tempMin]) { return $0 > $1 ? $1 : $0 }
            maxTemperature.merge([dayOfWeek: item.main.tempMax]) { return $0 > $1 ? $0 : $1 }
            firstDate.merge([dayOfWeek: dateConverter.convertDateFromUTC(string: item.dtTxt)]) { (first, second) in first }
            firstIcon.merge([dayOfWeek: item.weather[0].id]) { (first, second) in first }
    
        }
        
        var dailyWeatherItems = [ForecastViewModel]()
        for key in minTemperature.keys {
            let dailyWeatherItem = ForecastViewModel(icon: firstIcon[key]!, maxTemperature: maxTemperature[key]!, minTemperature: minTemperature[key]!, date: firstDate[key]!)
            
            dailyWeatherItems.append(dailyWeatherItem)
        }
        return dailyWeatherItems.sorted(by: { (first, second) in
            first.date < second.date
            })
        }
    
    func save() {
        let storageService = FavoriteCityStorageService()
        storageService.saveCoordinates(coordinates: weather.coord)
    }
     
    }
    

