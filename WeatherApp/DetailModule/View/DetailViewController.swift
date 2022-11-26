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
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TemperatureTableViewCell.self, forCellReuseIdentifier: "\(TemperatureTableViewCell.self)")
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TemperatureTableViewCell.self)", for: indexPath) as? TemperatureTableViewCell
       
       
        cell?.configureDataSource(weather: presenter.weather)
        
        
        return cell ?? UITableViewCell()
    }
    
    
    
}

extension DetailViewController: DetailViewInput {
    
}
