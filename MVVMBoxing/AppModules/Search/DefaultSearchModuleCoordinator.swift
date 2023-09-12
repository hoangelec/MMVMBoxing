//
//  SearchModuleCoordinator.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 11/09/2023.
//

import Foundation
import UIKit

protocol SearchModuleCoordinator: Coordinator {
    func showDetails(for movie: Movie)
}

final class DefaultSearchModuleCoordinator: SearchModuleCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    @MainActor @discardableResult func start() -> UIViewController {
        let searchViewController = SearchViewController(viewModel: DefaultSearchviewModel())
        searchViewController.coordinator = self
        navigationController.viewControllers = [searchViewController]
        return navigationController
    }
    
    func showDetails(for movie: Movie) {
        print("Movie selected: \(movie)")
    }
}

