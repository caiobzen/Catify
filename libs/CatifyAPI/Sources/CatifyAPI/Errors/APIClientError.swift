import Foundation

public enum APIClientError: Error {
    case invalidURL
    case errorFetchingData
    case genericError
    case noInternetConnection
    
    public var message: String {
        switch self {
        case .invalidURL:
            "Invalid Request to Cats Service."
        case .errorFetchingData:
            "Something went wrong while loading the Cats!"
        case .genericError:
            "Oops, something went wrong!"
        case .noInternetConnection:
            "No internet connection."
        }
    }
}
