//
//  MovieSearchTableViewCellModel.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 10/09/2023.
//

import Foundation
import UIKit
import NetworkKit
import FoundationKit

protocol MovieSearchResultViewModel {
    var title: String { get }
    var overview: String { get }
    var releaseDate: String { get }
    func loadImage(completion: @escaping (UIImage?) -> Void)
}

class DefaultMovieSearchResultViewModel: MovieSearchResultViewModel {
    
    var movie: Movie
    
    var title: String { movie.title }
    
    var overview: String { movie.overview }
    
    var releaseDate: String { movie.releaseDate }
    
    private let imageLoader: ImageLoader
    
    private let uiQueue: Dispatcher
    
    init(movie: Movie,
         imageLoader: ImageLoader = DefaultImageLoader(),
         uiQueue: Dispatcher = DispatchQueue.main
    ) {
        self.movie = movie
        self.imageLoader = imageLoader
        self.uiQueue = uiQueue
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let posterUrl = movie.posterUrl else { return }
        Task {
            let image = try? await imageLoader.loadImage(from: posterUrl)
            uiQueue.async {
                completion(image)
            }
        }
    }
}

extension Movie {
    var posterUrl: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
}
