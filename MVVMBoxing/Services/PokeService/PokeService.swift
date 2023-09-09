//
//  PokeService.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//

import NetworkKit

struct PokemonNameSearchResponse: Decodable {
    struct Sprite: Decodable {
        struct Other: Decodable {
            var home: [String: String]
        }
        
    }
    var name: String
    var height: Int
    var weight: Int
    var sprite: Sprite
}

protocol PokeService {
    func search(pokemonName: String) async throws -> PokemonNameSearchResponse
}

final class DefaultPokeService: PokeService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = DefaultNetworkClient.shared) {
        self.networkClient = networkClient
    }
    
    func search(pokemonName: String) async throws -> PokemonNameSearchResponse {
        return .init(name: "", height: 1, weight: 1, sprite: .init())
    }
    
    
}
