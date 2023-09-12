//
//  SearchModuleBuilder.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 11/09/2023.
//

import UIKit

final class SearchModuleBuilder {
    func build() -> Coordinator {
        let navigationController = UINavigationController()
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
        else {
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.tintColor = .systemBackground
        }
        
        return DefaultSearchModuleCoordinator(navigationController: navigationController)
    }
}
