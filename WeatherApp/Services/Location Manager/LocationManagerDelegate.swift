//
//  LocationManagerDelegate.swift
//  WeatherApp
//
//  Created by anita on 12/8/22.
//

import Foundation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(lat: Double, long: Double)
    func showLocationServicesDeniedAlert()
}
