//
//  GetBackgroundColor.swift
//  WeatherApp
//
//  Created by anita on 12/7/22.
//

import UIKit

struct GetBackgroundColor {
    
    let timezone: Int
    let date: Int
    init(timezone: Int, date: Int) {
        self.timezone = timezone
        self.date = date
    }
    
   private let dayColor = UIColor(named: "dayColor")!
   private let nightColor = UIColor(named: "nightColor")!
    
    func getBackgroundColor() -> UIColor {
        
        let dateConverter = DateConverter(timezone: timezone)
        let convertedDate = dateConverter.convertDateFromUTC(string: date)
        
        let isDay = dateConverter.compareTime(now: convertedDate, timeZone: timezone)
        return isDay ? dayColor : nightColor
    }
    
}
