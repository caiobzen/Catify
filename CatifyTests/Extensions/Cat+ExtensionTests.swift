import XCTest
@testable import CatifyDB

final class Cat_ExtensionTests: XCTestCase {

    func test_givenEmptyLifespan_ItReturnsAFallbackText() {
        
        // Arrange
        let cat = Cat(id: "",
                      image: nil,
                      breedName: nil,
                      origin: nil,
                      temperament: nil,
                      lifespan: nil,
                      desc: nil)
        
        // Act, Assert
        XCTAssertEqual(cat.detailText, "Unknown")
    }
    
    func test_givenInvalidLifespan_ItReturnsAFallbackText() {
        
        // Arrange
        let cat = Cat(id: "",
                      image: nil,
                      breedName: nil,
                      origin: nil,
                      temperament: "1 - 5 - 9",
                      lifespan: nil,
                      desc: nil)
        
        // Act, Assert
        XCTAssertEqual(cat.detailText, "Unknown")
    }
    
    func test_givenValidLifespanRange_ItReturnsTheAverageLifespan() {
        
        // Arrange
        let cat = Cat(id: "",
                      image: nil,
                      breedName: nil,
                      origin: nil,
                      temperament: nil,
                      lifespan: "15 - 17",
                      desc: nil)
        
        // Act, Assert
        XCTAssertEqual(cat.detailText, "16 years")
    }
}
