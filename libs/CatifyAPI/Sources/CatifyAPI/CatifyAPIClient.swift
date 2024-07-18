import Foundation

public struct CatifyAPIClient: CatifyAPIProtocol {
    
    private enum Constants {
        static let size = "size"
        static let hasBreeds = "has_breeds"
        static let includeBreeds = "include_breeds"
        static let quantity = "quantity"
        static let page = "page"
        static let limit = "limit"
    }
    
    let apiKey: String
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
    
        let queryItems = [
            URLQueryItem(name: Constants.size, value: size.rawValue),
            URLQueryItem(name: Constants.hasBreeds, value: hasBreeds.description),
            URLQueryItem(name: Constants.includeBreeds, value: includeBreeds.description),
            URLQueryItem(name: Constants.quantity, value: quantity.description),
            URLQueryItem(name: Constants.page, value: page.description),
            URLQueryItem(name: Constants.limit, value: limit.description)
        ]

        do {
            let urlRequest = try URLRequestFactory.create(for: .searchImages,
                                                          apiKey: apiKey,
                                                          queryItems: queryItems)
            let result = try await urlSession.data(for: urlRequest,
                                                   delegate: nil)
            let response = try JSONDecoder().decode(FetchCatsResponse.self,
                                                    from: result.0)
            return response
        } catch {
            throw APIClientError.errorFetchingData
        }
    }
}

public struct FetchCatsResponse: Decodable { }
