//
//  AppModuleBuilderContainer.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 28/09/2023.
//

import Factory

final class AppModuleBuilderContainer: SharedContainer {
    static var shared = AppModuleBuilderContainer()
    var manager = ContainerManager()

    var rootModuleBuilder: Factory<AppModuleBuilder> {
        self { SearchModuleBuilder() }.singleton
    }
}

