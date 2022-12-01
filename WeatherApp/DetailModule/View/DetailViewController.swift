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
    
    // MARK: - Views
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAppearance()
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
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
       // tableView.rowHeight = 500
        tableView.register(TemperatureTableViewCell.self, forCellReuseIdentifier: "\(TemperatureTableViewCell.self)")
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: "\(DetailsTableViewCell.self)")
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 500
        case 1:
            return 110
        default:
            return 150
        }
    }
    
    
    
    
}

extension DetailViewController: DetailViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    
}
