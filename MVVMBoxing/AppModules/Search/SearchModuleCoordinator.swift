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
    private let navigationController: UINavigationController
    private let searchViewControllerBuilder: SearchViewControllerBuilder
    private let movieDetailModuleBuilder: MovieDetailModuleBuilder
    
    init(navigationController: UINavigationController,
         searchViewControllerBuilder: SearchViewControllerBuilder = DefaultSearchViewControllerBuilder.common,
         movieDetailModuleBuilder: MovieDetailModuleBuilder = DefaultMovieDetailModuleBuilder.common
    ) {
        self.navigationController = navigationController
        self.searchViewControllerBuilder = searchViewControllerBuilder
        self.movieDetailModuleBuilder = movieDetailModuleBuilder
    }
    
    @MainActor @discardableResult func start() -> UIViewController {
        let searchViewController = searchViewControllerBuilder.build()
        searchViewController.coordinator = self
        navigationController.viewControllers = [searchViewController]
        return navigationController
    }
    
    func showDetails(for movie: Movie) {
        let detailsCoordinator = movieDetailModuleBuilder.build(in: navigationController, movie: movie)
        detailsCoordinator.start()
    }
}

