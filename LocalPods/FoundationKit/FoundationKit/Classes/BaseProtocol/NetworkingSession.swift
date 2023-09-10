//
//  NetworkingSession.swift
//  FoundationKit
//
//  Created by Hoang Cap on 09/09/2023.
//

public protocol NetworkingSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkingSession {}
