//
//  AppConfigurationContainer.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 09/09/2023.
//

import Factory
import FoundationKit

final class AppConfiguratorContainer: SharedContainer {
    static var shared = AppConfiguratorContainer()
    var manager = ContainerManager()
    
    var appConfigurator: Factory<AppConfigurator> {
        self { DefaultAppConfigurator.shared }.singleton
    }
}
