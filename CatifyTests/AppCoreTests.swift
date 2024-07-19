import XCTest
@testable import Catify
@testable import CatifyAPI

class AppCoreTests: XCTestCase {
    
    func test_onAppCoreCreation_itConfiguresAnAPIClient() {
        
        // Arrange, Act
        let core = AppCore()
        
        // Assert
        XCTAssertNoThrow(core.apiClient)
    }
    
    func test_onAppCoreCreation_itConfiguresADataBase() {
        
        // Arrange, Act
        let core = AppCore()
        
        // Assert
        XCTAssertNoThrow(core.dataBase)
    }
}
