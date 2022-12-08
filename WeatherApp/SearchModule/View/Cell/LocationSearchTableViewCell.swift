//
//  LocationSearchTableViewCell.swift
//  WeatherApp
//
//  Created by anita on 11/30/22.
//

import Foundation
import UIKit

final class LocationSearchTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cityNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
  // MARK: = Open Methods
    
    func configureDataSource(location: Location) {
        cityNameLabel.text = location.title
       
    }
}

    // MARK: - Private Methods

private extension LocationSearchTableViewCell {
    
    func setConstraints() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
}
