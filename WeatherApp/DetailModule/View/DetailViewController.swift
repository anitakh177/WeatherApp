//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Propertis
    
    var presenter: DetailViewPresenter!
    private var forecastViewModel = [ForecastViewModel]()
    
    // MARK: - Views
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        presenter.loadForecast()
       
    }
    
}

private extension DetailViewController {
    
    func configureAppearance() {
        configureTableView()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(close))
        leftItem.tintColor = .white
        navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFav))
        rightItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc func addToFav() {
        presenter.save()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
    }
    
    @objc func close() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func configureTableView() {
        tableView.backgroundColor = UIColor(named: "dayColor")
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
       
        tableView.register(TemperatureTableViewCell.self, forCellReuseIdentifier: "\(TemperatureTableViewCell.self)")
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "\(DetailsTableViewCell.self)")
        tableView.register(ForecstTableViewCell.self, forCellReuseIdentifier: "\(ForecstTableViewCell.self)")
        
        setTableConstaints()
    }
    
    func setTableConstaints() {
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

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
        case 2:
            return forecastViewModel.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TemperatureTableViewCell.self)", for: indexPath) as? TemperatureTableViewCell
            cell?.configureDataSource(weather: presenter.weather)
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailsTableViewCell.self)", for: indexPath) as? DetailsTableViewCell
            cell?.updateCell(with: presenter.weather)
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ForecstTableViewCell.self)", for: indexPath) as? ForecstTableViewCell
            cell?.configureDataSource(forecast: forecastViewModel[indexPath.row])
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
            }
        }
      
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 450
            } else {
                return 110
            }
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "5-DAY FORECAST"
        }
        return ""
    }

}

extension DetailViewController: DetailViewInput {
    func updateForecast(_ model: [ForecastViewModel]) {
        forecastViewModel = model
        tableView.reloadData()
    }
    
    
    
    func reloadData() {
        tableView.reloadData()
    }
    
    
}
