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
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        registerAppConfiguration()
        
        let viewController = SearchViewController(viewModel: .init())
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        
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
