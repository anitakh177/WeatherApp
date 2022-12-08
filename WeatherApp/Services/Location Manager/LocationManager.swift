//
//  LocationManager.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    
    // MARK: - Properties
    
    weak var delegate: LocationManagerDelegate?
    fileprivate let locationManager = CLLocationManager()
    
    // MARK: - Initialization
    
    override init() {
           super.init()
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
       }
    
    // MARK: - Open Methods
    
    func startUpdating() {
    attemptLocationAccess()
    }

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
    
    func attemptLocationAccess() {
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                return
            }
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            
            self.locationManager.delegate = self
            let authStatus = self.locationManager.authorizationStatus
            if authStatus == .notDetermined {
                self.locationManager.requestWhenInUseAuthorization()
            } else {
                self.locationManager.requestLocation()
            }
            if authStatus == .denied || authStatus == .restricted {
                DispatchQueue.main.async {
                    self.delegate?.showLocationServicesDeniedAlert()
                }
            }
        }
    }
}

// MARK: - Loccaton Manager Delegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            delegate?.didUpdateLocation(lat: location.coordinate.latitude, long: location.coordinate.longitude)

        }
    }
}
