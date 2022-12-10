//
//  ViewController.swift
//  WeatherApp
//
//  Created by anita on 11/23/22.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController, ModuleTransitionable {
    
    // MARK: - Views
    
    private let tableView = UITableView()
    private var serachController = UISearchController()
    
    // MARK: - Properties
    
    var presenter: MainViewOutput!

    // MARK: - Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        createNotifition()
        presenter.loadCoordinatesFromStorage()
        
    }
    
}

// MARK: - Main View Input

extension MainViewController: MainViewInput {
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func createNotifition() {
        NotificationCenter.default.addObserver(self, selector: #selector(notificateArray), name: Notification.Name("reload"), object: nil)
    }
    
    @objc func notificateArray() {
        presenter.loadCoordinatesFromStorage()
      //  tableView.reloadData()
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
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
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

// MARK: Table View Delegate & DataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return presenter.savedWeather.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CurrentWeatherTableViewCell.self)", for: indexPath) as? CurrentWeatherTableViewCell
            cell?.selectionStyle = .none
            if let weather = presenter.currentWeather {
                cell?.configureDataSource(weather: weather)
                }
            return cell ?? UITableViewCell()
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CurrentWeatherTableViewCell.self)", for: indexPath) as? CurrentWeatherTableViewCell
            
             let weather = presenter.savedWeather
                cell?.configureDataSource(weather: weather[indexPath.row])
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
        }
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         if indexPath.section == 0 {
             if let weather = presenter?.currentWeather {
                 presenter.pushDetailVC(weather: weather)
             }
         } else {
             if let weather = presenter?.savedWeather {
                 presenter.pushDetailVC(weather: weather[indexPath.row])
             }
         }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "CURRENT LOCATION"
        case 1:
            return "FAVORITE CITY"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.delete(index: indexPath.row, indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
       
    }
}

