import Foundation

public protocol CatifyAPIProtocol {
    
    func fetchCatImages(size: ImageSize,
                        quantity: Int,
                        page: Int,
                        limit: Int,
                        hasBreeds: Bool,
                        includeBreeds: Bool) async throws -> FetchCatsResponse
}

public protocol URLSessionProtocol {
    func data(for request: URLRequest,
              delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

public struct CatifyAPIClient: CatifyAPIProtocol {
    
    let apiKey: String
    let baseURL = "https://api.thecatapi.com/v1/"
    let urlSession: URLSessionProtocol
    
    public init(apiKey: String,
                urlSession: URLSessionProtocol = URLSession.shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }
    
    public func fetchCatImages(size: ImageSize,
                               quantity: Int = 1,
                               page: Int = 1,
                               limit: Int = 1,
                               hasBreeds: Bool = true,
                               includeBreeds: Bool = true) async throws -> FetchCatsResponse {
        
        guard var url = URL(string: baseURL) else {
            throw APIClientError.invalidURL
        }
        
        url.append(path: "images/search")
        
        url.append(queryItems: [
            URLQueryItem(name: "size", value: size.rawValue),
            URLQueryItem(name: "has_breeds", value: hasBreeds ? "true" : "false"),
            URLQueryItem(name: "include_breeds", value: includeBreeds ? "true" : "false"),
            URLQueryItem(name: "quantity", value: "\(quantity)"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ])
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let result = try await urlSession.data(for: urlRequest, delegate: nil)
            print(String(data: result.0, encoding: .utf8))
            let response = try JSONDecoder().decode(FetchCatsResponse.self, from: result.0)
            return response
        } catch {
            throw APIClientError.errorFetchingData
        }
    }
}

public struct FetchCatsResponse: Decodable {

}

public enum ImageSize: String {
    case thumb
    case small
    case med
    case full
}

public enum APIClientError: Error {
    case invalidURL
    case errorFetchingData
}
