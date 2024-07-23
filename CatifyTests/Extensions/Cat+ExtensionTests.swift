import XCTest
@testable import CatifyDB

final class Cat_ExtensionTests: XCTestCase {

    func test_givenEmptyLifespan_ItReturnsAFallbackText() {
        
        // Arrange
        let cat = makeCatWith(lifespan: nil)
        
        // Act, Assert
        XCTAssertEqual(cat.detailText, "Avg. Lifespan:\nUnknown")
    }
    
    func test_givenInvalidLifespan_ItReturnsAFallbackText() {
        
        // Arrange
        let cat = makeCatWith(lifespan: "1 - 5 - 7")
        
        // Act, Assert
        XCTAssertEqual(cat.detailText, "Avg. Lifespan:\nUnknown")
    }
    
    func test_givenValidLifespanRange_ItReturnsTheAverageLifespan() {
        
        // Arrange
        let cat = makeCatWith(lifespan: "15 - 17")
        
        // Act, Assert
        XCTAssertEqual(cat.detailText, "Avg. Lifespan:\n16 years")
    }
}

//MARK: - Extensions
private extension Cat_ExtensionTests {

    func makeCatWith(lifespan: String?) -> Cat {
        Cat(id: "",
            image: nil,
            breedName: nil,
            origin: nil,
            temperament: nil,
            lifespan: lifespan,
            desc: nil)
    }
}
