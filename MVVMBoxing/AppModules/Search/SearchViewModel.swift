//
//  ViewModel.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//


import Combine
import Factory

protocol SearchViewModel {
    var searchResult: [Movie] { get }
    func scheduleSearch(keyword: String)
    func buildCellViewModel(at index: Int) async -> MovieSearchResultViewModel
}

final class DefaultSearchviewModel: SearchViewModel {
    @MainActor @Published var searchResult: [Movie] = []
    
    private var previousTask: Task<Void, Error>?
    
    private var bindings = [AnyCancellable]()
    
    @LazyInjected(\ServicesContainer.moviesService)
    private var service: MoviesService //  `service` is injected at runtime, we don't need explicitly write DI code in its initialization
    
    func scheduleSearch(keyword: String) {
        previousTask?.cancel()
        if keyword.isEmpty {
            Task {
                await MainActor.run {
                    searchResult = []
                }
            }
        }
        guard keyword.count > 3 else { return }
        
        previousTask = Task.detached { [self] in
            try await Task.sleep(nanoseconds: 250_000_000)
            do {
                let movies = try await service.search(movieName: keyword)
                await MainActor.run {
                    searchResult = movies
                }
            } catch {
                print(error)
            }
        }
    }
    
    func buildCellViewModel(at index: Int) async -> MovieSearchResultViewModel {
        DefaultMovieSearchResultViewModel(movie: await self.searchResult[index])
    }
}
