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
        label.textColor = .white
        label.font = .systemFont(ofSize: 35, weight: .regular)
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "05.partial-cloudy-dark")
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .regular)
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50, weight: .regular)
        return label
    }()
    
    private lazy var highAndLowTemp: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .regular)
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
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configureDataSource(weather: CurrentWeather) {
        let icon = IconWithString(timezone: weather.timezone, date: weather.dt)
        let image = icon.getIcon(with: weather.weather.first!.id)
        
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


