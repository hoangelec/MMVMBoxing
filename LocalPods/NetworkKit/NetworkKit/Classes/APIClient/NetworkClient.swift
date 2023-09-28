import FoundationKit

public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
}

// !!! For this demo, the implementation only support GET request now.
public protocol NetworkClient {
    func request<Response: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: HTTPHeaders?,
        parameters: [String : Any]?
    ) async throws -> Response
}

extension NetworkClient {
    public func get<Response: Decodable>(
        url: URL,
        headers: HTTPHeaders? = nil
    ) async throws -> Response {
        try await self.request(url: url, method: .get, headers: headers, parameters: [:])
    }
}


public final class NonTestableNetworkClient: NetworkClient {
    
    public static let shared = NonTestableNetworkClient()
    
    private let jsonDecoder: JSONDecoder = .init()
    private let session: URLSession = .shared
    
    public func request<Response>(
        url: URL,
        method: HTTPMethod,
        headers: HTTPHeaders?,
        parameters: [String : Any]?)
    async throws -> Response where Response : Decodable {
        let request = URLRequest(url: url, method: method, headers: headers)
        
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else { throw "Invalid response from server" }
        guard response.statusCode == 200 else {
            throw "Error encountered. Status code \(response.statusCode)"
        }
        
        return try jsonDecoder.decode(Response.self, from: data)
    }
}












public final class DefaultNetworkClient: NetworkClient {
    
    public static let shared = DefaultNetworkClient()
    
    private let jsonDecoder: ModelDecoder
    private let session: NetworkingSession
    
    init(jsonDecoder: ModelDecoder = JSONDecoder(), session: NetworkingSession = URLSession.shared) {
        self.jsonDecoder = jsonDecoder
        self.session = session
    }
    // thisi is just a simplified implementation, and it on support GET by now
    public func request<Response>(
        url: URL,
        method: HTTPMethod,
        headers: HTTPHeaders?,
        parameters: [String : Any]?)
    async throws -> Response where Response : Decodable {
        let request = URLRequest(url: url, method: method, headers: headers)
        
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else { throw "Invalid response from server" }
        guard response.statusCode == 200 else {
            throw "Error encountered. Status code \(response.statusCode)"
        }
        
        return try jsonDecoder.decode(Response.self, from: data)
    }
}
