
extension URLRequest {
    public init(url: URL, method: HTTPMethod, headers: [String: String]? = nil) {
        self.init(url: url)
        httpMethod = method.rawValue
        allHTTPHeaderFields = headers
    }
}
