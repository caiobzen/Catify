import XCTest
@testable import CatifyDB

final class CatifyDBTests: XCTestCase {
    
    var catifyDB: CatifyDataBase!
    
    override func setUpWithError() throws {
        catifyDB = try CatifyDataBase()
    }
    
    @MainActor
    override func tearDown() {
        catifyDB.deleteAllCats()
    }
    
    @MainActor
    func test_fetchCatsEmpty() {
        
        // Arrange, Act
        let cats = catifyDB.fetchCats()
        
        // Assert
        XCTAssertTrue(cats.isEmpty)
    }
    
    @MainActor
    func test_insertCat() {
        
        // Arrange
        let catMock = makeCatMockWith(id: "1")
        catifyDB.insert(cat: catMock)
        
        // Act
        let cats = catifyDB.fetchCats()
        
        // Assert
        XCTAssertEqual(cats.count, 1)
        XCTAssertEqual(cats.first?.id, catMock.id)
    }
    
    @MainActor
    func test_fetchMultipleCats() {
        
        // Arrange
        let anotherCat = makeCatMockWith(id: "2")
        catifyDB.insert(cat: makeCatMockWith(id: "1"))
        catifyDB.insert(cat: anotherCat)
        
        // Act
        let cats = catifyDB.fetchCats()
        
        // Assert
        XCTAssertEqual(cats.count, 2)
    }
    
    @MainActor
    func test_toggleCatFavorite() throws {
        
        // Arrange
        let catMock = makeCatMockWith(id: "1")
        catifyDB.insert(cat: catMock)
        
        // Act
        catifyDB.toggleFavorite(catId: "1")
        let cats = catifyDB.fetchCats()
        let firstCat = try XCTUnwrap(cats.first)
        
        // Assert
        XCTAssertTrue(firstCat.isFavorite)
    }
}

extension XCTestCase {
    
    func makeCatMockWith(id: String) -> Cat {
        Cat(
            id: id,
            image: URL(string: "http://cat.com")!,
            breedName: "",
            origin: "",
            temperament: "",
            lifespan: "",
            desc: "",
            isFavorite: false
        )
    }
}
