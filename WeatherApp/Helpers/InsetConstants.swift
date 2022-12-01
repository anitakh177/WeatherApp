//
//  InsetConstants.swift
//  WeatherApp
//
//  Created by anita on 12/1/22.
//


import UIKit

struct InsetConstants {
    static let leftDistanceToView: CGFloat = 16
    static let rightDistanceToView: CGFloat = 16
    static let minimumLineSpacing: CGFloat = 13
    static let itemWidth = (UIScreen.main.bounds.width - InsetConstants.leftDistanceToView - InsetConstants.rightDistanceToView - (InsetConstants.minimumLineSpacing / 2)) / 4.5
    static let itemHeight: CGFloat = 100
}
