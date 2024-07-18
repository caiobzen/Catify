import XCTest
@testable import Catify
@testable import CatifyAPI

class AppCoreTests: XCTestCase {
    
    func test_onAppCoreCreation_itConfiguresAnAPIClient() {
        
        let core = AppCore()
        XCTAssertNoThrow(core.apiClient)
    }
}
