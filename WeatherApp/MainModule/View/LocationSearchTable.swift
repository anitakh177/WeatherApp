//
//  LocationSearchTable.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//

import UIKit
//import CoreLocation

class LocationSearchTable: UITableViewController {
    
    // MARK: - Properties

    var presenter: MainViewOutput?
    var locations: [Location] = []

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // tableView.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.identifier)
        tableView.dataSource = self

       
    }
    
    
}

extension LocationSearchTable: MainViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    
}
// MARK: - UISearch delegate
extension LocationSearchTable: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let text = searchController.searchBar.text, !text.isEmpty {
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


// MARK: - Table view data source and delegate

extension LocationSearchTable {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = locations[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coordinate = locations[indexPath.row].coordinates
        
        presenter?.loadData(for: coordinate!)
      //  delegate?.locationViewController(self, didSelectLocationWith: coordinate)
        
        let configurator = DetailModuleConfigurator()
        
        if let weather = presenter?.currentWeather {
           let controller =  configurator.configure(weather: weather)
            navigationController?.pushViewController(controller, animated: true)
        }
        
       // dismiss(animated: true)
    }
    
    
    

}
