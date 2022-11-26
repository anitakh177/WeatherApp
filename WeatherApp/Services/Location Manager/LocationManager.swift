//
//  LocationManager.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//

import Foundation
import CoreLocation



class LocationManager: NSObject {
    
   static let shared = LocationManager()
    
    public func findLocations(with query: String, completion: @escaping(([Location]) -> Void)) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return
            }
            
            let models: [Location] = places.compactMap({ place in
                var name = ""
                if let locationName = place.name {
                    name += locationName
                }
                
                
                if let country = place.country {
                   name += ", \(country)"
                }
                
    
                let result = Location(title: name, coordinates: place.location?.coordinate)
                
                return result
            })
            completion(models)
        }
        
    }
}
