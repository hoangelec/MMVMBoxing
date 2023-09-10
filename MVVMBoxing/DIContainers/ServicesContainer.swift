//
//  ServicesContainer.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 10/09/2023.
//

import FoundationKit
import Factory

final class ServicesContainer: SharedContainer {
    static var shared = ServicesContainer()
    var manager = ContainerManager()
    
    var pokeService: Factory<MoviesService> {
        self { DefaultMoviesService() }.singleton
    }
}
