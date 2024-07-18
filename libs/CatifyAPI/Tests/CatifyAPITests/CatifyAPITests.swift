import XCTest
@testable import CatifyAPI

final class CatifyAPITests: XCTestCase {
    
    var urlSessionSpy: URLSessionSpy!
    
    override func setUp() {
        urlSessionSpy = URLSessionSpy()
    }
    
    func test_fetchCatImages_ProducesExpectedRequest() async {

        // Arrange
        let client = CatifyAPIClient(apiKey: "", urlSession: urlSessionSpy)

        // Act
        _ = try? await client.fetchCatImages(
            size: .med,
            quantity: 10,
            page: 0,
            limit: 1,
            hasBreeds: false,
            includeBreeds: true
        )
        
        // Assert
        XCTAssertEqual(urlSessionSpy.request?.url?.absoluteString, "https://api.thecatapi.com/v1/images/search?size=med&has_breeds=false&include_breeds=true&quantity=10&page=0&limit=1")
        XCTAssertNotNil(urlSessionSpy.request?.value(forHTTPHeaderField: "x-api-key"))
        XCTAssertNotNil(urlSessionSpy.request?.value(forHTTPHeaderField: "Content-Type"))
    }
}

// MARK: - Spy
class URLSessionSpy: URLSessionProtocol {
    
    var request: URLRequest?

    func data(for request: URLRequest,
              delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        
        self.request = request

        return (Data(), URLResponse())
    }
}
