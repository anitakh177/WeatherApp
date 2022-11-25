//
//  ViewController.swift
//  WeatherApp
//
//  Created by anita on 11/23/22.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    var presenter: MainViewOutput!
    private let tableView = UITableView()
    private let serachController = UISearchController(searchResultsController: nil)
    var locations = [Location]()
    
    var locationManager = CLLocationManager()
    
    
    var filteredData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        attemptLocationAccess()
        
    }


}

extension MainViewController: MainViewInput {
    
}
// MARK: - Private Methods

private extension MainViewController {
    
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
                    self.showLocationServicesDeniedAlert()
                }
            }
        }
    }
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func configureView() {
        view.backgroundColor = .white
        navigationItem.title = "Weather"
        navigationItem.searchController = serachController
        serachController.searchBar.delegate = self
        
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return locations.count
    }
    
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = locations[indexPath.row].title
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coordinate = locations[indexPath.row].coordinates
         presenter.loadData(for: coordinate!)
    }
    
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let text = searchBar.text, !text.isEmpty {
            self.locations = []
            LocationManager.shared.findLocations(with: text) { [weak self] location in
            
                DispatchQueue.main.async {
                    self?.locations += location
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
}


extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            presenter.loadData(for: location.coordinate)
            print(location)
                }
        
    }
}
