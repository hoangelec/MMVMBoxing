//
//  MovieDetailSceneBuilder.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 28/09/2023.
//

import Foundation
import UIKit

protocol MovieDetailSceneBuilder {
    func build(in container: UIViewController, movie: Movie) -> Coordinator
}

enum DefaultMovieDetailSceneBuilder: MovieDetailSceneBuilder {
    case common
    func build(in container: UIViewController, movie: Movie) -> Coordinator {
        DefaultMovieDetailSceneCoordinator(movie: movie, container: container)
    }
}

protocol MovieDetailViewControllerBuilder {
    func build(movie: Movie) -> MovieDetailViewController
}

enum DefaultMovieDetailViewControllerBuilder: MovieDetailViewControllerBuilder {
    case common
    func build(movie: Movie) -> MovieDetailViewController {
        let viewModel = DefaultMovieDetailViewModel(movie: movie)
        return MovieDetailViewController(viewModel: viewModel)
    }
}
