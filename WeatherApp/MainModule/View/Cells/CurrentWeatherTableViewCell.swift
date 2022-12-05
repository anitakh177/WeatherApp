//
//  CurrentWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//

import UIKit

class CurrentWeatherTableViewCell: UITableViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
   
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
        label.font = .systemFont(ofSize: 50, weight: .semibold)
        return label
    }()
    
    private lazy var highAndLowTemp: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .semibold)
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
        contentView.addSubview(iconImageView)
        contentView.addSubview(myLocationLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(highAndLowTemp)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        myLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        highAndLowTemp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            myLocationLabel.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: 40),
            myLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            myLocationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            cityLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -60),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityLabel.topAnchor.constraint(equalTo: myLocationLabel.bottomAnchor, constant: 5),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            
            
            tempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            iconImageView.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor, constant: -16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 120),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            
            highAndLowTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            highAndLowTemp.topAnchor.constraint(equalTo: tempLabel.bottomAnchor)
            
        ])
        myLocationLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func configureDataSource(weather: CurrentWeather) {
        
        let dateConverter = DateConverter(timezone: weather.timezone)
        let convertedDate = dateConverter.convertDateFromUTC(string: weather.dt)
        let icon = IconWithString()
        let isDay = dateConverter.compareTime(now: convertedDate, timeZone: weather.timezone)
     
        let image = icon.getIcon(with: weather.weather.first!.id, isDay: isDay)
        iconImageView.image = UIImage(named: image)
        
        
        cityLabel.text = weather.name
        descriptionLabel.text = weather.weather.first!.main
        tempLabel.text = String(format: "%.f", weather.main.temp) + "°"
        let tempHigh = String(format: "%.f", weather.main.tempMax)
        let tempLow = String(format: "%.f", weather.main.tempMin)
        highAndLowTemp.text = "H: \(tempHigh)° L: \(tempLow)°"
        
       
    }
}
