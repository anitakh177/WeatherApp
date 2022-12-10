//
//  GetBackgroundColor.swift
//  WeatherApp
//
//  Created by anita on 12/7/22.
//

import UIKit

struct GetBackgroundColor {
    
  private  let timezone: Int
  private let date: Int
    
    lazy var dayGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [day1Color.cgColor, day1Color.cgColor,
            beigeColor.cgColor
        ]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()
    
    lazy var nightGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        
        gradient.colors = [blueColor.cgColor,
                           nightColor.cgColor
        ]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()
    
    init(timezone: Int, date: Int) {
        self.timezone = timezone
        self.date = date
    }
    
   private let day1Color = UIColor(named: "day1Color")!
    private let day2Color = UIColor(named: "day2Color")!
   private let nightColor = UIColor(named: "nightColor")!
    private let beigeColor = UIColor(named: "beigeColor")!
    private let blueColor = UIColor(named: "blueColor")!
    
    mutating func getBackgroundColor() -> CAGradientLayer {
        
        let dateConverter = DateConverter(timezone: timezone)
        let convertedDate = dateConverter.convertDateFromUTC(string: date)
        
        let isDay = dateConverter.compareTime(now: convertedDate, timeZone: timezone)
        return isDay ? dayGradient : nightGradient
    }
    
    func getDetailsColor() -> UIColor {
        
        let dateConverter = DateConverter(timezone: timezone)
        let convertedDate = dateConverter.convertDateFromUTC(string: date)
        
        let isDay = dateConverter.compareTime(now: convertedDate, timeZone: timezone)
        return isDay ? day1Color : nightColor
        
    }
    
}
