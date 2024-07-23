import XCTest
@testable import CatifyUI

final class ImageCacheTests: XCTestCase {

    func test_sharedInstance() {
        XCTAssertNotNil(ImageCache.shared)
    }

    func test_setAndGetImage() {
        
        // Arrange
        let imageCache = ImageCache.shared
        let testImage = UIImage()
        let testKey = "testKey"

        // Act
        imageCache.set(testImage, forKey: testKey)

        // Assert
        XCTAssertEqual(testImage, imageCache.get(forKey: testKey))
    }

    func test_getNonExistentImage() {
        
        // Arrange
        let nonExistentKey = "nonExistentKey"

        // Act
        let retrievedImage = ImageCache.shared.get(forKey: nonExistentKey)

        // Assert
        XCTAssertNil(retrievedImage)
    }

    func test_cacheCountLimit() {
        
        XCTAssertEqual(ImageCache.shared.cache.countLimit, 50)
    }
    
    func test_itSetsPlaceholderImage_whenTheresNoImageCached() {
        
    }
}
