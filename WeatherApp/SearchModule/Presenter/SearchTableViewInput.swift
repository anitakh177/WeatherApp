//
//  SearchTableViewInput.swift
//  WeatherApp
//
//  Created by anita on 11/27/22.
//

import Foundation

protocol SearchTableViewInput {
    func reloadData()
    func showEmptyView()
    func hideEmptyView()
}
