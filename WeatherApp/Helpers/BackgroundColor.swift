//
//  DarkGradientView.swift
//  WeatherApp
//
//  Created by anita on 12/14/22.
//

import UIKit

final class BackgroundColor {
    
    private let dayColor = UIColor(named: "dayColor")!
    private let nightColor = UIColor(named: "nightColor")!
    private let beigeColor = UIColor(named: "beigeColor")!
    private let blueColor = UIColor(named: "blueColor")!
  
    lazy var dayGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [dayColor.cgColor, dayColor.cgColor,
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
    
    func getDetailsColor(isDay: Bool) -> UIColor {
        return isDay ? dayColor : nightColor
        
    }
}
