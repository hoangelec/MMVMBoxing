//
//  NetworkEndPoints.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 09/09/2023.
//

import Factory
import FoundationKit

protocol NetworkEndPointsProvider {
    var pokeSearch: String { get }
}

final class DefaultNetworkEndPointsProvider {
    
    @LazyInjected(\AppConfiguratorContainer.appConfigurator)
    private var appConfigurator: AppConfigurator
    
//    init() {
//        self.appConfigurator = appConfigurator
//    }
    
    var pokeSearch: String {
        switch appConfigurator.currentConfiguration {
        case .debug: return "https://pokeapi.co/api/v2/pokemon/"
        case .release: return "https://pokeapi.co/api/v2/pokemon/"
        }
    }
}
