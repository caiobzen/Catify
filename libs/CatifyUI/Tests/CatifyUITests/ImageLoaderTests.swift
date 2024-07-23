import XCTest
@testable import CatifyUI

final class ImageLoaderTests: XCTestCase {
    
    var imageLoader: ImageLoader!
    var url: URL!
    var mockCache: MockImageCache!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        url = URL(string: "https://example.com/image.png")!
        mockCache = MockImageCache()
        mockSession = MockURLSession()
        imageLoader = ImageLoader(url: url,
                                  cache: mockCache,
                                  urlSession: mockSession)
    }
    
    func test_setPlaceholderImage() async {
        // Arrange
        mockCache.cache.removeAll()
        
        // Act
        imageLoader = ImageLoader(url: url)
        // wait for async task to complete
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        // Assert
        XCTAssertEqual(
            imageLoader.image?.pngData(),
            UIImage(
                contentsOfFile: Bundle.module.path(
                    forResource: "placeholder",
                    ofType: "png")!
            )?.pngData()
        )
    }
}

// MARK: - Mocks
class MockImageCache: ImageCacheProtocol {
    var cache: [String: UIImage] = [:]
    
    func get(forKey key: String) -> UIImage? { cache[key] }
    func set(_ image: UIImage, forKey key: String) { cache[key] = image }
}

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}
