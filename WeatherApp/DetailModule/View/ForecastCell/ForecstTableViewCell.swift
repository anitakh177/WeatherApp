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
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dayOfWeek: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [dayOfWeek, dateLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, temperatureLabel, verticalStack])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(horizontalStack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
        
    }
    
    func configureDataSource(forecast: ForecastViewModel) {
        let tempHigh = String(format: "%.f", forecast.maxTemperature)
        let tempLow = String(format: "%.f", forecast.minTemperature)
        temperatureLabel.text = " H: \(tempHigh)\nL:  \(tempLow)"
        dayOfWeek.text = forecast.date.getDayOfWeek()
        dateLabel.text = forecast.date.getDate()
        
    
        let icon = IconWithString()
        let image = icon.getIcon(with: forecast.icon, isDay: true)
        iconImageView.image = UIImage(named: image)
        
    
    }
}

// MARK: - Private Methods

private extension ForecstTableViewCell {
    
    func setConstraints() {
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
