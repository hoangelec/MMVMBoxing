//
//  PokeService.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//

import NetworkKit
import FoundationKit

protocol MoviesService {
    func search(movieName: String) async throws -> [Movie]
}

extension DefaultMoviesService {
    struct Response: Decodable {
        var results: [Movie]
    }
}

final class DefaultMoviesService: MoviesService {
    private static let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYzAxYjM5NWZhOWQyNzRiZDdiNzdjNzk1MzQ5MzhmOSIsInN1YiI6IjY0ZmQyNjBhNjY0NjlhMDBjNjdiNmNjZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VDeEcnVHZN6_o9ScmKnwfCZcd2YnC2n29obpFLNQukE"
    
    private let networkClient: NetworkClient
    private let endpointProvider: NetworkEndPointsProvider
    
    init(
        networkClient: NetworkClient = DefaultNetworkClient.shared,
        endpointProvider: NetworkEndPointsProvider = DefaultNetworkEndPointsProvider.common
    ) {
        self.networkClient = networkClient
        self.endpointProvider = endpointProvider
    }
    
    func search(movieName: String) async throws -> [Movie] {
        guard let url = URL(string: endpointProvider.search)?
            .appendingQueryItem(name: "query", value: movieName) else {
            throw "Could not construct url for search request"
        }
        let headers: [String: String] = ["Authorization" : "Bearer \(Self.apiKey)"]
        let response: DefaultMoviesService.Response = try await networkClient.get(url: url, headers: headers)
        
        return response.results
    }
}
