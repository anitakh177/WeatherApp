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
    
    private let tableView = UITableView()
    
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
        let leftNavBar = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        leftNavBar.tintColor = .black
        navigationItem.leftBarButtonItem = leftNavBar
    }
    
    @objc func close() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
       // tableView.rowHeight = 500
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return forecastViewModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(TemperatureTableViewCell.self)", for: indexPath) as? TemperatureTableViewCell
                cell?.configureDataSource(weather: presenter.weather)
                return cell ?? UITableViewCell()
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(DetailsTableViewCell.self)", for: indexPath) as? DetailsTableViewCell
                cell?.updateCell(with: presenter.weather)
                return cell ?? UITableViewCell()
                
            default:
                return UITableViewCell()
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ForecstTableViewCell.self)", for: indexPath) as? ForecstTableViewCell
            cell?.configureDataSource(forecast: forecastViewModel[indexPath.row])
            return cell ?? UITableViewCell()
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 500
            } else {
                return 110
            }
        default:
            return 110
        }
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
