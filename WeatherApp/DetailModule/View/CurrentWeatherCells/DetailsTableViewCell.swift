//
//  DetailsTableViewCell.swift
//  WeatherApp
//
//  Created by anita on 12/1/22.
//

import UIKit

final class DetailsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var model: CurrentWeather!
    
    // MARK: - Views

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = InsetConstants.minimumLineSpacing
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: InsetConstants.itemWidth, height: InsetConstants.itemHeight)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .clear
        contentView.backgroundColor = UIColor(named: "dayColor")
        contentView.alpha = 0.9
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: "\(DetailsCollectionViewCell.self)")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(collectionView)
        setConstraints()
    }
    
    func updateCell(with model: CurrentWeather) {
        self.model = model
        collectionView.reloadData()
    }
    
}

// MARK: - Private Methods

private extension DetailsTableViewCell {
    
    func setConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8),
        
        ])
    }
    
}

extension DetailsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DetailsCollectionViewCell.self)", for: indexPath) as? DetailsCollectionViewCell
          switch indexPath.item {
          case 0:
              let number = String(format: "%.f", model!.main.feelsLike)
              cell?.backgroundColor = .clear
              cell?.configureDataSource(icon: UIImage(systemName: "thermometer.medium")!, title: "Feels Like", number: "\(number)°")

          case 1:
              cell?.backgroundColor = .clear
              cell?.configureDataSource(icon: UIImage(systemName: "humidity")!, title: "Humidity", number: "\(model?.main.humidity ?? 0)%")
          case 2:
              cell?.backgroundColor = .clear
              cell?.configureDataSource(icon: UIImage(systemName: "cloud")!, title: "Clouds", number: "\(model?.clouds.all ?? 0)")
          
          case 3:
              cell?.backgroundColor = .clear
              let number = String(format: "%.f", model!.wind.speed)
              cell?.configureDataSource(icon: UIImage(systemName: "wind")!, title: "Wind", number: number)
              
          default:
              cell?.configureDataSource(icon: UIImage(systemName: "nosign")!, title: "", number: "")
          }
        return cell ?? UICollectionViewCell()
    }
    
    
    
}
