//
//  ForecstTableViewCell.swift
//  WeatherApp
//
//  Created by anita on 12/2/22.
//

import UIKit

final class ForecstTableViewCell: UITableViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var dayOfWeek: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.alpha = 0.7
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dayOfWeek, dateLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconImageView)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(verticalStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    func configureBackgroundColor(weather: CurrentWeather) {
        let getColor = GetBackgroundColor(timezone: weather.timezone, date: weather.dt)
        contentView.backgroundColor = getColor.getBackgroundColor().withAlphaComponent(0.9)
    }
    
    func configureDataSource(forecast: ForecastViewModel) {
        let tempHigh = String(format: "%.f", forecast.maxTemperature)
        let tempLow = String(format: "%.f", forecast.minTemperature)
        temperatureLabel.text = " H: \(tempHigh)\nL: \(tempLow)"
        dayOfWeek.text = forecast.date.getDayOfWeek()
        dateLabel.text = forecast.date.getDate()
        
        let icon = IconWithString(timezone: 0, date: 0)
        let image = icon.getIcon(with: forecast.icon)
        iconImageView.image = UIImage(named: image)
        
    }
}

// MARK: - Private Methods

private extension ForecstTableViewCell {
    
    func setConstraints() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            iconImageView.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor, constant: -4),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.heightAnchor.constraint(equalToConstant: 70),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: verticalStack.leadingAnchor, constant: -4),
            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            verticalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            verticalStack.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
