//
//  ImageLoader.swift
//  FoundationKit
//
//  Created by Hoang Cap on 10/09/2023.
//

import Foundation
import FoundationKit

public protocol ImageLoader {
    func loadImage(from url: URL) async throws -> UIImage
}

public actor DefaultImageLoader: ImageLoader {
    
    typealias SessionBuilder = () -> URLSession
    
    private let session: URLSession

    init(sessionBuilder: SessionBuilder) {
        self.session = sessionBuilder()
    }
    
    public init() {
        self.init(sessionBuilder: Self.sessionBuilder)
    }
    
    public func loadImage(from url: URL) async throws -> UIImage {
            let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw "Invalid data response from \(url)"
        }
        return image
    }
    
    static func sessionBuilder() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration)
    }
}
