//
//  LocationSearchTable.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//


import UIKit

final class LocationSearchTable: UITableViewController, ModuleTransitionable {
    
    // MARK: - Properties

    var presenter: SearchTableViewOutput?
    var locations: [Location]?
    
    // MARK: - Views
    
    private lazy var searchBar = UISearchBar()
    private lazy var emptyResultView: EmptyResultView = {
        let view = EmptyResultView()
        view.isHidden = true
        return view
    }()
    
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
        configureEmptyResultView()
    }
    
    func createSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 56, y: 0, width: 300, height: 32))
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
        tableView.rowHeight = 40
        
    }
    
    func configureEmptyResultView() {
        view.addSubview(emptyResultView)
        NSLayoutConstraint.activate([
            emptyResultView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 314),
            emptyResultView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyResultView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 16),
            emptyResultView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - Search Table View Input

extension LocationSearchTable: SearchTableViewInput {
    func hideEmptyView() {
        emptyResultView.isHidden = true
    }
    
    func showEmptyView() {
        emptyResultView.isHidden = false
    }
    
    func reloadData() {
        tableView.reloadData()
    }

}

// MARK: - UISearch delegate
extension LocationSearchTable: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, !text.isEmpty {
            presenter?.searchLocation(for: text)
           // presenter?.loadData()
        }
    }
    
}


// MARK: - Table view data source and delegate

extension LocationSearchTable {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let locations = presenter?.locations else { return 0 }
        return locations.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(LocationSearchTableViewCell.self)", for: indexPath) as? LocationSearchTableViewCell else { return UITableViewCell() }
        if let locations = presenter?.locations {
            cell.configureDataSource(location: locations[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let locations = presenter?.locations else { return }
        let coordinate = locations[indexPath.row].coordinates
        self.presenter?.loadData(for: coordinate!.latitude, long: coordinate!.longitude)
    
        if let weather = presenter?.currentWeather {
            self.presenter?.pushDetailVC(weather: weather)
            }
       
        }
    }

