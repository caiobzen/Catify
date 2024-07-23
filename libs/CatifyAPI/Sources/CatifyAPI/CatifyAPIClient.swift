import Foundation

public struct CatifyAPIClient: CatifyAPIProtocol {
    
    private enum Constants {
        static let size = "size"
        static let hasBreeds = "has_breeds"
        static let includeBreeds = "include_breeds"
        static let quantity = "quantity"
        static let page = "page"
        static let limit = "limit"
        static let order = "order"
    }
    
    let apiKey: String
    let urlSession: URLSessionProtocol
    
    public init(apiKey: String,
                urlSession: URLSessionProtocol = URLSession.shared) {
        self.apiKey = apiKey
        self.urlSession = urlSession
    }
    
    public func fetchCatImages(size: ImageSize,
                               page: Int = 1,
                               limit: Int = 1,
                               hasBreeds: Bool = true,
                               includeBreeds: Bool = true,
                               order: Order = .asc) async throws -> [CatImage] {
    
        let queryItems = [
            URLQueryItem(name: Constants.size, value: size.rawValue),
            URLQueryItem(name: Constants.hasBreeds, value: hasBreeds.description),
            URLQueryItem(name: Constants.includeBreeds, value: includeBreeds.description),
            URLQueryItem(name: Constants.page, value: page.description),
            URLQueryItem(name: Constants.limit, value: limit.description),
            URLQueryItem(name: Constants.order, value: order.rawValue)
        ]

        do {
            let urlRequest = try URLRequestFactory.create(for: .searchImages,
                                                          apiKey: apiKey,
                                                          queryItems: queryItems)
            urlRequest.log()
            let result = try await urlSession.data(for: urlRequest,
                                                   delegate: nil)
            let response = try JSONDecoder().decode([CatImage].self,
                                                    from: result.0)
            return response
        } catch {
            if let error = error as? URLError {
                switch error.code {
                case .networkConnectionLost:
                    throw APIClientError.noInternetConnection
                default:
                    throw APIClientError.errorFetchingData
                }
            } else {
                throw APIClientError.genericError
            }
        }
    }
}
