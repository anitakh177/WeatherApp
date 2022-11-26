//
//  CurrentWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {
    
    private lazy var myLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "My Location"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        contentView.addSubview(myLocationLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(tempLabel)
        
        myLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myLocationLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: 40),
            myLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            myLocationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            cityLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: 40),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cityLabel.topAnchor.constraint(equalTo: myLocationLabel.bottomAnchor, constant: 5),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            
        
        ])
        myLocationLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func configureDataSource(weather: CurrentWeather) {
        cityLabel.text = weather.name
        descriptionLabel.text = weather.weather.first!.main
        tempLabel.text = "\(weather.main.temp)"
    }
}
