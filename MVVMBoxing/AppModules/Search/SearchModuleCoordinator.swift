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
    let searchViewControllerBuilder: SearchViewControllerBuilder
    
    init(navigationController: UINavigationController, searchViewControllerBuilder: SearchViewControllerBuilder = DefaultSearchViewControllerBuilder.common) {
        self.navigationController = navigationController
        self.searchViewControllerBuilder = searchViewControllerBuilder
    }
    
    @MainActor @discardableResult func start() -> UIViewController {
        let searchViewController = searchViewControllerBuilder.build()
        searchViewController.coordinator = self
        navigationController.viewControllers = [searchViewController]
        return navigationController
    }
    
    func showDetails(for movie: Movie) {
        let detailsCoordinator = DefaultMovieDetailModuleBuilder().build(in: navigationController, movie: movie)
        detailsCoordinator.start()
    }
}

