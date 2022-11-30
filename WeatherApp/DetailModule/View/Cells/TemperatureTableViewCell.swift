//
//  TemperatureTableViewCell.swift
//  WeatherApp
//
//  Created by anita on 11/25/22.
//

import UIKit

class TemperatureTableViewCell: UITableViewCell {
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .medium)
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "05.partial-cloudy-dark")
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "It's cloudy"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "29"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .bold)
        return label
    }()
    
    private lazy var highAndLowTemp: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cityLabel, iconImageView, descriptionLabel, temperatureLabel, highAndLowTemp])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
        
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(verticalStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       setConstaints()
    }
    
  private  func setConstaints() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40)
        ])
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
        temperatureLabel.text = String(format: "%.f", weather.main.temp) + "°"
        let tempHigh = String(format: "%.f", weather.main.tempMax)
        let tempLow = String(format: "%.f", weather.main.tempMin)
        highAndLowTemp.text = "H: \(tempHigh)° L: \(tempLow)°"
        
       
        
        
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        cityLabel.text = nil
        descriptionLabel.text = nil
        temperatureLabel.text = nil
        highAndLowTemp.text = nil
    }

}


