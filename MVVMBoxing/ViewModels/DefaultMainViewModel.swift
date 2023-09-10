//
//  ViewModel.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//


import Combine
import Factory

protocol MainViewModel {
    var searchResult: [Movie]? { get }
    func scheduleSearch(keyword: String)
}


final class DefaultMainViewModel {
    
    @Published var searchResult: [Movie]?
    
    private var previousTask: Task<Void, Error>?
    
    @LazyInjected(\ServicesContainer.moviesService)
    private var service: MoviesService
    
    func scheduleSearch(keyword: String) {
        previousTask?.cancel()
        guard keyword.count > 3 else { return }
        
        previousTask = Task.detached { [self] in
            print("Schedule search for: \(keyword)")
            try await Task.sleep(nanoseconds: 1000_000_000)
            print("Started search for: \(keyword)")
            do {
                let movies = try await service.search(movieName: keyword)
                if keyword == "Once" { try await Task.sleep(nanoseconds: 4000_000_000) }
                searchResult = movies
            } catch {
                print(error)
            }
        }
        
    }
    
//    var timer: Timer?
//    //  let service = FakeService()
//
//    private let servie
//
//    let debounceTime = 0.25
//    var lastKeyword = ""
//    func scheduleSearch(keyword: String, completion: @escaping (Result<[String], Error>) -> Void) {
        
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
//    }
}
