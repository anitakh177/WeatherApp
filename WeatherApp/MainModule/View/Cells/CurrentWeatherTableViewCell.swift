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
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(roundedView)
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
        var getColor = GetBackgroundColor(timezone: weather.timezone, date: weather.dt)
        getColor.nightGradient.frame = roundedView.bounds
        getColor.dayGradient.frame = roundedView.bounds
        roundedView.layer.addSublayer(getColor.getBackgroundColor())
        
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
        roundedView.addSubview(iconImageView)
        roundedView.addSubview(cityLabel)
        roundedView.addSubview(descriptionLabel)
        roundedView.addSubview(tempLabel)
        roundedView.addSubview(highAndLowTemp)
        
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        highAndLowTemp.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
    
            cityLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 8),
            cityLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 8),
            cityLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
           
            descriptionLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -8),
            

            tempLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -8),
            tempLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 8),
            
            iconImageView.trailingAnchor.constraint(equalTo: tempLabel.leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: roundedView.centerYAnchor),
            iconImageView.centerXAnchor.constraint(equalTo: roundedView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 120),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            
            highAndLowTemp.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -16),
            highAndLowTemp.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -8)
            
        ])
        
        cityLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        tempLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
       
    }
}
