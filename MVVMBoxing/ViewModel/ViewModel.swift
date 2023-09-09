//
//  ViewModel.swift
//  MVVMBoxing
//
//  Created by Hoang Cap on 08/09/2023.
//

import FoundationKit

struct FakeService {
  func search(keyword: String, completion: @escaping (Result<[String], Error>) -> Void) {
    DispatchQueue.global().async {
        print("Request fired: \(keyword)")
      var result = [String]()
      for i in 0 ... Int.random(in: 0...5) {
        result.append("\(keyword)\(i)")
      }
      if keyword == "abc" {
          DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(5))  {
          completion(.success(result))
        }
      } else {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(Int.random(in: 1...2)))  {
          completion(.success(result))
        }
      }
    }
  }
}

class MyViewModel {
  var timer: Timer?
  let service = FakeService()
  let debounceTime = 0.25
  var lastKeyword = ""
  func scheduleSearch(keyword: String, completion: @escaping (Result<[String], Error>) -> Void) {
    timer?.invalidate()
    timer = nil
    guard !keyword.isEmpty else {
      print("Reset result")
      return completion(.success([]))
    }
    guard keyword.count > 2 else {
      print("Short keyword: \(keyword)")
      return
    }
    
    lastKeyword = keyword
    
    timer = Timer.scheduledTimer(withTimeInterval: debounceTime, repeats: false, block: { [weak self] timer in
      guard let self = self else { return }
      self.service.search(keyword: keyword) { [weak self] result in
        print("self.service.search: \(result.value) for keyword: \(keyword)")
        guard keyword == self?.lastKeyword else {
          return
        }
        completion(result)
      }
      self.timer = nil
    })
  }
}
