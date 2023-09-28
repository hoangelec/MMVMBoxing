//
//  MovieDetailModuleBuilder.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 28/09/2023.
//

import Foundation
import UIKit

protocol MovieDetailModuleCoordinator: Coordinator {}

final class DefaultMovieDetailModuleCoordinator: MovieDetailModuleCoordinator {

    private let movieDetailViewControllerBuilder: MovieDetailViewControllerBuilder
    private let container: UIViewController
    private let movie: Movie

    init(movie: Movie,
         container: UIViewController,
         movieDetailViewControllerBuilder: MovieDetailViewControllerBuilder = DefaultMovieDetailViewControllerBuilder.common) {
        self.movie = movie
        self.container = container
        self.movieDetailViewControllerBuilder = movieDetailViewControllerBuilder
    }

    @MainActor @discardableResult func start() -> UIViewController {
        let movieDetailViewController = movieDetailViewControllerBuilder.build(movie: movie)
        container.present(movieDetailViewController, animated: true)
        return movieDetailViewController
    }
}
