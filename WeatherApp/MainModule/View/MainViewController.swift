//
//  ViewController.swift
//  WeatherApp
//
//  Created by anita on 11/23/22.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, SelectedCellProtocol {
    
    func didSelectedCell(weather: CurrentWeather) {
        let configurator = DetailModuleConfigurator()
        let controller = configurator.configure(weather: weather)
       navigationController?.pushViewController(controller, animated: true)
    }
    
    
    // MARK: - Views
    private let tableView = UITableView()
 /*   private let serachController: UISearchController = {
        let configurator = MainModuleConfigurator()
        let locationSearchTable = configurator.searchTableConfigurator()
        let search = UISearchController(searchResultsController: locationSearchTable)
        search.searchResultsUpdater = locationSearchTable //as? any UISearchResultsUpdating
        return search
    }()
    */
    
    private var serachController = UISearchController()
    
    // MARK: - Properties
    
    var presenter: MainViewOutput!
    var locations = [Location]()
    var locationManager = CLLocationManager()

    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureView()
        attemptLocationAccess()
        
    }

}

extension MainViewController: MainViewInput {
    func reloadData() {
        tableView.reloadData()
    }
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
        let configurator = MainModuleConfigurator()
        let locationSearchTable = configurator.searchTableConfigurator()
       serachController = UISearchController(searchResultsController: locationSearchTable)
        serachController.searchResultsUpdater = locationSearchTable //as? any UISearchResultsUpdating
   //  let search = LocationSearchTable()
        locationSearchTable.delegateSearch = self
        
        view.backgroundColor = .white
        navigationItem.title = "Weather"
        navigationItem.searchController = serachController
        navigationItem.titleView = serachController.searchBar
        serachController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        serachController.searchBar.delegate = self
        
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(CurrentWeatherTableViewCell.self, forCellReuseIdentifier: "\(CurrentWeatherTableViewCell.self)")
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return 1
    }
    
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(CurrentWeatherTableViewCell.self)", for: indexPath) as? CurrentWeatherTableViewCell
        if let weather = presenter.currentWeather {
            cell?.configureDataSource(weather: weather)
            
            }
        return cell ?? UITableViewCell()
       
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         let configurator = DetailModuleConfigurator()
         
         if let weather = presenter?.currentWeather {
            let controller =  configurator.configure(weather: weather)
             navigationController?.pushViewController(controller, animated: true)
         }
        
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
