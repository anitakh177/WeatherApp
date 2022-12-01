//
//  DetailsCollectionViewCell.swift
//  WeatherApp
//
//  Created by anita on 12/1/22.
//

import UIKit

final class DetailsCollectionViewCell: UICollectionViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [iconImageView, titleLabel, numberLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
      
    }
    
    func configureDataSource(icon: UIImage, title: String, number: String) {
        iconImageView.image = icon
        titleLabel.text = title
        numberLabel.text = number
    }
    
}

// MARK: - Private Methods

private extension DetailsCollectionViewCell {
    
    func setConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
