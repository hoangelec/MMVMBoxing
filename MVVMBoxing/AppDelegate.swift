//
//  AppDelegate.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//

import UIKit
import FoundationKit
import NetworkKit
import Factory

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var coordinator: Coordinator?

    @LazyInjected(\AppSceneBuilderContainer.rootModuleBuilder)
    private var rootBuilder: AppSceneBuilder
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        registerAppConfiguration() // Handle different envs/configurations
        
        // We can abstract the builder to make this testable later
        coordinator = rootBuilder.build() // -> this gives me an Coordinator
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // coordinator?.start() will setup the view hierarchy for Search feature
        // and then assign the navigation controller to the window's rootVC
        window?.rootViewController = coordinator?.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func registerAppConfiguration() {
        
        let configurator = AppConfiguratorContainer.shared.appConfigurator()
#if DEBUG
        configurator.setAppConfiguration(.debug)
#else
        configurator.setAppConfiguration(.release)
#endif
    }
}
