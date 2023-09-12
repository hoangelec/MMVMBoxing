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
            //Configure additional customizations here
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
        
        else {
            
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.tintColor = .systemBackground
        }
        
        return SearchModuleCoordinator(navigationController: navigationController)
    }
}

final class SearchModuleCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor @discardableResult func start() -> UIViewController {
        let searchViewController = SearchViewController(viewModel: DefaultSearchviewModel())
        navigationController.viewControllers = [searchViewController]
        return navigationController
    }
}
