import Foundation
@testable import CatifyAPI

// MARK: - Mock
class URLSessionMock: URLSessionProtocol {
    
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    var urlRequest: URLRequest?

    func data(for request: URLRequest,
              delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        
        self.urlRequest = request
        
        return (
            self.mockData ?? Data(),
            self.mockResponse ?? URLResponse()
        )
    }
}
