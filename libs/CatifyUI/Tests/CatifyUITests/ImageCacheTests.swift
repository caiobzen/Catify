import XCTest
@testable import CatifyUI

final class ImageCacheTests: XCTestCase {

    func testSharedInstance() {
        XCTAssertNotNil(ImageCache.shared)
    }

    func testSetAndGetImage() {
        
        // Arrange
        let imageCache = ImageCache.shared
        let testImage = UIImage()
        let testKey = "testKey"

        // Act
        imageCache.set(testImage, forKey: testKey)

        // Assert
        XCTAssertEqual(testImage, imageCache.get(forKey: testKey))
    }

    func testGetNonExistentImage() {
        
        // Arrange
        let nonExistentKey = "nonExistentKey"

        // Act
        let retrievedImage = ImageCache.shared.get(forKey: nonExistentKey)

        // Assert
        XCTAssertNil(retrievedImage)
    }

    func testCacheCountLimit() {
        
        XCTAssertEqual(ImageCache.shared.cache.countLimit, 50)
    }
}
