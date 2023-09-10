import FoundationKit

extension URL {
    public func appendingQueryItem(name: String, value: String?) -> URL? {
        guard var urlComponents = URLComponents(string: absoluteString) else { return nil }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}
