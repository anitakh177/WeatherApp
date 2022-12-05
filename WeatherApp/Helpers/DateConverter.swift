//
//  DateConverter.swift
//  WeatherApp
//
//  Created by anita on 11/29/22.
//

import Foundation

struct DateConverter {
    private let timezone: Double
    
    init(timezone: Int) {
        self.timezone = Double(timezone)
    }
    
    func convertDateFromUTC(string: String) -> Date {
        let utcDate = convertDate(from: string)
        return utcDate.addingTimeInterval(self.timezone)
    }
    
    func convertDateFromUTC(string: Int) -> Date {
        
        let utcDate = convertDate(from: String(string))
        return utcDate.addingTimeInterval(self.timezone)
    }
    
    private func convertDate(from string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: string) ?? Date()
    }
    
    func compareTime(now: Date, timeZone: Int) -> Bool {
        
        let calendar = Calendar.current
        let eight_today = calendar.date(
          bySettingHour: 8,
          minute: 0,
          second: 0,
          of: now)!

        let four_thirty_today = calendar.date(
          bySettingHour: 16,
          minute: 30,
          second: 0,
          of: now)!
        
        if now >= eight_today &&
          now <= four_thirty_today
        {
         return true
        }
      return false
    }
}

