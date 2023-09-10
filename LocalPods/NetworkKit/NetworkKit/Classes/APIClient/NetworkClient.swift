import FoundationKit

public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
}

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

public final class DefaultNetworkClient: NetworkClient {
    
    public static let shared = DefaultNetworkClient()
    
    private let jsonDecoder: JSONDecoder
    private let session: URLSession
    
    init(jsonDecoder: JSONDecoder = .init(), session: URLSession = .shared) {
        self.jsonDecoder = jsonDecoder
        self.session = session
    }
    
    public func request<Response>(
        url: URL,
        method: HTTPMethod,
        headers: HTTPHeaders?,
        parameters: [String : Any]?)
    async throws -> Response where Response : Decodable {
        let request = URLRequest(url: url, method: method, headers: headers)
        
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else { throw "Invalid response from server" }
        print("response: \(response)")
        guard response.statusCode == 200 else {
            throw "Error encountered. Status code \(response.statusCode)"
        }

        guard let json = data.toJson else {
            throw "Error encountered. Invalid response"
        }
        
        print("json: \(String(describing: json))")
        
        return try jsonDecoder.decode(Response.self, from: data)
    }
}
