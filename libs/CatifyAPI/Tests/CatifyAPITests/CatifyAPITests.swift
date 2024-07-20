import XCTest
@testable import CatifyAPI

final class CatifyAPITests: XCTestCase {
    
    private var urlSessionMock: URLSessionMock!
    private var client: CatifyAPIClient!
    
    override func setUp() {
        urlSessionMock = URLSessionMock()
        client = CatifyAPIClient(apiKey: "", urlSession: urlSessionMock)
    }
    
    func test_fetchCatImages_producesExpectedRequest() async {

        // Arrange, Act
        _ = try? await client.fetchCatImages(
            size: .med,
            page: 0,
            limit: 1,
            hasBreeds: false,
            includeBreeds: true
        )
        
        // Assert
        XCTAssertEqual(urlSessionMock.urlRequest?.url?.absoluteString, "https://api.thecatapi.com/v1/images/search?size=med&has_breeds=false&include_breeds=true&page=0&limit=1&order=asc")
        XCTAssertNotNil(urlSessionMock.urlRequest?.value(forHTTPHeaderField: "x-api-key"))
        XCTAssertNotNil(urlSessionMock.urlRequest?.value(forHTTPHeaderField: "Content-Type"))
    }
    
    func test_fetchCatImages_decodesWithSuccess() async {
        
        // Arrange
        urlSessionMock.mockData = dataFromJsonFile(named: "searchResponseMock")
        
        // Act
        let response = try? await client.fetchCatImages(
            size: .med,
            page: 0,
            limit: 1,
            hasBreeds: true,
            includeBreeds: true
        )
        
        // Assert
        XCTAssertEqual(
            response?.first,
            CatImage(
                id: "cat id",
                url: URL(string: "https://cdn2.thecatapi.com/images/xBR2jSIG7.jpg")!,
                width: 2048,
                height: 2048,
                breeds: [
                    Breed(
                        id: "breed id",
                        name: "breed name",
                        origin: "breed origin",
                        temperament: "breed temperament",
                        description: "breed description"
                    )
                ])
            )
    }
}
