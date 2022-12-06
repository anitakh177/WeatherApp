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
   
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
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
        contentView.backgroundColor = UIColor(named: "dayColor")?.withAlphaComponent(0.7)
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
    
            cityLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -16),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
           
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: cityLabel.bottomAnchor, constant: 10),
            
            
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
