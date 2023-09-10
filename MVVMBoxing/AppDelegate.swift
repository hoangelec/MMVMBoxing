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
    
    var service = DefaultMoviesService.init()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        registerAppConfiguration()
        
        
        
        Task.detached {
            async let response = self.service.search(movieName: "Once upon")
            
            do {
                let data = try await response
                print("Response data: \(data)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
            
            
            
        }
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
