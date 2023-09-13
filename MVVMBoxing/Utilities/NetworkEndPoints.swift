//
//  NetworkEndPoints.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 09/09/2023.
//

import Factory
import FoundationKit

protocol NetworkEndPointsProvider {
    var search: String { get }
}

enum DefaultNetworkEndPointsProvider: NetworkEndPointsProvider {
    case common
    
    private var host: String {
        switch Self.appConfigurator.currentConfiguration {
        case .debug: return "https://api.themoviedb.org"
        case .release: return "https://api.themoviedb-prod.org"
        }
    }
    
    @LazyInjected(\AppConfiguratorContainer.appConfigurator)
    private static var appConfigurator: AppConfigurator 
    
    var search: String {
        host.appending("/3/search/movie")
    }
}
