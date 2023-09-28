//
//  SearchSceneCoordinator.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 11/09/2023.
//

import Foundation
import UIKit

protocol SearchSceneCoordinator: Coordinator {
    func showDetails(for movie: Movie)
}

final class DefaultSearchSceneCoordinator: SearchSceneCoordinator {
    private let navigationController: UINavigationController
    private let searchViewControllerBuilder: SearchViewControllerBuilder
    private let movieDetailSceneBuilder: MovieDetailSceneBuilder
    
    init(navigationController: UINavigationController,
         searchViewControllerBuilder: SearchViewControllerBuilder = DefaultSearchViewControllerBuilder.common,
         movieDetailModuleBuilder: MovieDetailSceneBuilder = DefaultMovieDetailSceneBuilder.common
    ) {
        self.navigationController = navigationController
        self.searchViewControllerBuilder = searchViewControllerBuilder
        self.movieDetailSceneBuilder = movieDetailModuleBuilder
    }
    
    @MainActor @discardableResult func start() -> UIViewController {
        let searchViewController = searchViewControllerBuilder.build()
        searchViewController.coordinator = self
        navigationController.viewControllers = [searchViewController]
        return navigationController
    }
    
    func showDetails(for movie: Movie) {
        let detailsCoordinator = movieDetailSceneBuilder.build(in: navigationController, movie: movie)
        detailsCoordinator.start()
    }
}

