//
//  CurrentWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//

import UIKit

final class CurrentWeatherTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
   
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 45, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var highAndLowTemp: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
       super.layoutSubviews()
        setConstraints()
    }
    
   
    // MARK: - Open Methods
    
    func configureDataSource(weather: CurrentWeather) {
        let getColor = GetBackgroundColor(timezone: weather.timezone, date: weather.dt)
        contentView.backgroundColor = getColor.getBackgroundColor()
        
        let icon = IconWithString(timezone: weather.timezone, date: weather.dt)
        let image = icon.getIcon(with: weather.weather.first!.id)
        iconImageView.image = UIImage(named: image)
        
        cityLabel.text = weather.name
        descriptionLabel.text = weather.weather.first!.main
        tempLabel.text = String(format: "%.f", weather.main.temp) + "°"
        let tempHigh = String(format: "%.f", weather.main.tempMax)
        let tempLow = String(format: "%.f", weather.main.tempMin)
        highAndLowTemp.text = "H: \(tempHigh)° L: \(tempLow)°"
        
       
    }
}

// MARK: - Private Methods

private extension CurrentWeatherTableViewCell {
    
    func setConstraints() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(cityLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(highAndLowTemp)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        highAndLowTemp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
    
            cityLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cityLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
           
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            iconImageView.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 120),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            
            highAndLowTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            highAndLowTemp.topAnchor.constraint(equalTo: tempLabel.bottomAnchor)
            
        ])
        
        cityLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        tempLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
       
    }
}
