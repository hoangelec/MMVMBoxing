//
//  AppDelegate.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//

import UIKit
import FoundationKit
import NetworkKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var coordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        registerAppConfiguration()
        
        // We can abstract the builder to make this testable later
        coordinator = SearchModuleBuilder().build()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // coordinator?.start() will setup the view hierarchy for Search feature
        // and then assign the navigation controller to the window's rootVC
        window?.rootViewController = coordinator?.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func registerAppConfiguration() {
        // Don't mind that this is yet, it just simply return an AppConfigurator object
        let configurator = AppConfiguratorContainer.shared.appConfigurator()
#if DEBUG
        configurator.setAppConfiguration(.debug)
#else
        configurator.setAppConfiguration(.release)
#endif
    }
}
