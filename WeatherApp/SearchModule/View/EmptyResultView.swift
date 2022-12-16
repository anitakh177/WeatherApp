//
//  EmptyResultView.swift
//  WeatherApp
//
//  Created by anita on 12/15/22.
//

import UIKit

final class EmptyResultView: UIView {
    
    //MARK: - Views
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "🫠")
        return image
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.text = "Result is Empty"
        return label
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        addSubview(textLabel)
        configureImageView()
        configureTextLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Private methods

private extension EmptyResultView {
    
    func configureImageView() {
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -14),
                                     imageView.widthAnchor.constraint(equalToConstant: 32), imageView.heightAnchor.constraint(equalToConstant: 32),
                                     imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     ])
    }
    
    func configureTextLabel() {
        NSLayoutConstraint.activate([textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                                     textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
                                    ])
    }
}
