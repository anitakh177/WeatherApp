//
//  LocationSearchTableViewCell.swift
//  WeatherApp
//
//  Created by anita on 11/30/22.
//

import Foundation
import UIKit

class LocationSearchTableViewCell: UITableViewCell {
    
    
    private lazy var myLocationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myLocationLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    func setConstraints() {
        myLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myLocationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            myLocationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            myLocationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        ])
    }
    
    
    func configureDataSource(location: Location) {
        myLocationLabel.text = location.title
       
    }
}
