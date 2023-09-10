//
//  ViewModel.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//


import Combine
import Factory

class MainViewModel {
    
    @Published var searchResult: PokemonNameSearchResponse?
    
    private var previousTask: Task<PokemonNameSearchResponse, Error>?
    
    @LazyInjected(\ServicesContainer.pokeService)
    private var service: MoviesService
    
    func scheduleSearch(keyword: String) async throws -> PokemonNameSearchResponse {
        return try await service.search(movieName: keyword)
    }
    
    
//    var timer: Timer?
//    //  let service = FakeService()
//
//    private let servie
//
//    let debounceTime = 0.25
//    var lastKeyword = ""
    func scheduleSearch(keyword: String, completion: @escaping (Result<[String], Error>) -> Void) {
//        timer?.invalidate()
//        timer = nil
//        guard !keyword.isEmpty else {
//            print("Reset result")
//            return completion(.success([]))
//        }
//        guard keyword.count > 2 else {
//            print("Short keyword: \(keyword)")
//            return
//        }
//
//        lastKeyword = keyword
//
//        timer = Timer.scheduledTimer(withTimeInterval: debounceTime, repeats: false, block: { [weak self] timer in
//            guard let self = self else { return }
//            self.service.search(keyword: keyword) { [weak self] result in
//                print("self.service.search: \(result.value) for keyword: \(keyword)")
//                guard keyword == self?.lastKeyword else {
//                    return
//                }
//                completion(result)
//            }
//            self.timer = nil
//        })
    }
}
