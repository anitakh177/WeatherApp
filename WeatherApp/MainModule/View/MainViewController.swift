//
//  ViewController.swift
//  WeatherApp
//
//  Created by anita on 11/23/22.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, ModuleTransitionable {
    
    // MARK: - Views
    private let tableView = UITableView()
 
    
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
       
        view.backgroundColor = .white
        navigationItem.title = "Weather"
       
        configureTableView()
        configureNavigationBar()
    }
    func configureNavigationBar() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearchVC))
        rightBarButtonItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func openSearchVC() {
        presenter.pushSearchVC()
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
        tableView.register(CurrentWeatherTableViewCell.self, forCellReuseIdentifier: "\(CurrentWeatherTableViewCell.self)")
        setTableConstraints()
    }
                                    
    func setTableConstraints() {
     view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
                                        
     NSLayoutConstraint.activate([
                            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                            tableView.topAnchor.constraint(equalTo: view.topAnchor),
                            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                    ])
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
         if let weather = presenter?.currentWeather {
             presenter.pushDetailVC(weather: weather)
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

        }
    }
}
