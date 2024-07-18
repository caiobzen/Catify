import Foundation

struct URLRequestFactory {
    
    private enum Constants {
        static let baseURL = "https://api.thecatapi.com/v1/"
    }
    
    static func create(for path: APIPath,
                       apiKey: String,
                       queryItems: [URLQueryItem]) throws -> URLRequest {
        
        guard var url = URL(string: Constants.baseURL) else {
            throw APIClientError.invalidURL
        }
        
        url.append(path: path.rawValue)
        url.append(queryItems: queryItems)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
}
