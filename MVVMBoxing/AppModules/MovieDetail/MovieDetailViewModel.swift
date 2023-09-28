//
//  MovieDetailViewModel.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 11/09/2023.
//

import Foundation
import UIKit
import NetworkKit
import FoundationKit

protocol MovieDetailViewModel: AnyObject {
    var title: String { get }
    var overview: String { get }
    var releaseDate: String { get }
    func loadImage(completion: @escaping (UIImage?) -> Void)
}

typealias DefaultMovieDetailViewModel = DefaultMovieSearchResultViewModel

extension DefaultMovieDetailViewModel: MovieDetailViewModel {}

