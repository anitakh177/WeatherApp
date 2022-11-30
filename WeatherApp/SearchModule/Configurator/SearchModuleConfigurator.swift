//
//  SearchModuleConfigurator.swift
//  WeatherApp
//
//  Created by anita on 11/30/22.
//

import Foundation

final class SearchModuleConfigurator {
    
    func searchTableConfigurator() -> LocationSearchTable {
        let view = LocationSearchTable()
        let dataFetcherService = DataFetcherService()
        let presenter = SearchTableViewPresenter(view: view, dataFetcherService: dataFetcherService)
        view.presenter = presenter
        let router = SearchRouter()
        presenter.router = router
        router.view = view
        return view
    }
}
