//
//  LocationSearchTable.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//


import UIKit

class LocationSearchTable: UITableViewController, ModuleTransitionable {
    
    // MARK: - Properties

    var presenter: SearchTableViewOutput?
    var locations: [Location]?
    
    // MARK: - Views
    
    private lazy var searchBar = UISearchBar()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureAppearance()
       
    }
    
    
}

// MARK: - Private Methods

private extension LocationSearchTable {
     
    func configureAppearance() {
        configureTableView()
        createSearchBar()
        configureNavigationBar()
    }
    
    func createSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 56, y: 5, width: 300, height: 32))
        searchBar.placeholder = "Search for a city"
        searchBar.delegate = self
    }
    
    func configureNavigationBar() {
        let rightNavBar = UIBarButtonItem(customView: searchBar)
        navigationItem.rightBarButtonItem = rightNavBar
   
        let leftNavBar = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: navigationController, action: #selector(navigationController!.popViewController(animated:)))
        leftNavBar.tintColor = .black
        navigationItem.leftBarButtonItem = leftNavBar
        
    }
    
    func configureTableView() {
        tableView.register(LocationSearchTableViewCell.self, forCellReuseIdentifier: "\(LocationSearchTableViewCell.self)")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension LocationSearchTable: SearchTableViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    
    
    
}
// MARK: - UISearch delegate
extension LocationSearchTable: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.locations = []
        if let text = searchBar.text, !text.isEmpty {
           
            LocationManager.shared.findLocations(with: text) { [weak self] location in
            
                DispatchQueue.main.async {
                    self?.locations! += location
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
}


// MARK: - Table view data source and delegate

extension LocationSearchTable {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let locations = locations else { return 0 }
            return locations.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LocationSearchTableViewCell.self)", for: indexPath) as! LocationSearchTableViewCell
       
        if let locations = locations {
            cell.configureDataSource(location: locations[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let locations = locations else { return }
            let coordinate = locations[indexPath.row].coordinates
        self.presenter?.loadData(for: coordinate!.latitude, long: coordinate!.longitude)
            
            if let weather = presenter?.currentWeather {
                presenter?.pushDetailVC(weather: weather)
            }
        }
    }

