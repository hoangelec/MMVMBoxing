//
//  MovieDetailModuleBuilder.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 28/09/2023.
//

import Foundation
import UIKit

protocol MovieDetailModuleBuilder {
    func build(in container: UIViewController, movie: Movie) -> Coordinator
}

final class DefaultMovieDetailModuleBuilder {
    func build(in container: UIViewController, movie: Movie) -> Coordinator {
        DefaultMovieDetailModuleCoordinator(movie: movie, container: container)
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
