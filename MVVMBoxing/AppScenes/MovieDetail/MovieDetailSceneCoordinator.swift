//
//  MovieDetailSceneCoordinator.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 28/09/2023.
//

import Foundation
import UIKit

protocol MovieDetailSceneCoordinator: Coordinator {}

final class DefaultMovieDetailSceneCoordinator: MovieDetailSceneCoordinator {

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
