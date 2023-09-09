import Alamofire
import FoundationKit

public protocol NetworkClient {
    func request<Response: Decodable>(
        url: URL,
        method: HTTPMethod,
        headers: [HTTPHeader],
        parameters: [String : Any]
    ) async throws -> Response
}

extension NetworkClient {
    public func get<Response: Decodable>(
        url: URL,
        headers: [HTTPHeader] = []
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
        headers: [HTTPHeader],
        parameters: [String : Any])
    async throws -> Response where Response : Decodable {
        let request = try URLRequest(url: url, method: method, headers: .init(headers))
        
        let (data, response) = try await session.data(for: request)
        guard let response = response as? HTTPURLResponse else { throw "Invalid response from server" }
        guard response.statusCode == 200 else {
            throw "Error encountered. Status code \(response.statusCode)"
        }
        return try jsonDecoder.decode(Response.self, from: data)
    }
}
