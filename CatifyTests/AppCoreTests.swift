import XCTest
@testable import Catify
@testable import CatifyAPI

class AppCoreTests: XCTestCase {
    
    func test_onAppCoreCreation_itConfiguresAnAPIClient() {
        
        // Arrange
        let core = AppCore()
        
        // Act, Assert
        XCTAssertNoThrow(core.apiClient)
    }
}
