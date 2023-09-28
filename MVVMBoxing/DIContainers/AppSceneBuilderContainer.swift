//
//  AppSceneBuilderContainer.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 28/09/2023.
//

import Factory

final class AppSceneBuilderContainer: SharedContainer {
    static var shared = AppSceneBuilderContainer()
    var manager = ContainerManager()

    var rootModuleBuilder: Factory<AppSceneBuilder> {
        self { SearchSceneBuilder() }.singleton
    }
}

