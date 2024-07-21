import XCTest
@testable import Catify

final class CatDetailViewModelTests: XCTestCase {
    
    private var apiMock: CatifyAPIMock!
    private var dataBaseMock: CatifyDataBaseMock!
    private var viewModel: CatDetailViewModel!
    
    override func setUp() {
        apiMock = CatifyAPIMock()
        dataBaseMock = CatifyDataBaseMock()
    }

    func test_onInit_ifAnInvalidIdIsGiven_itReturnsAnInvalidCat() {
        
        viewModel = CatDetailViewModel(
            repository: CatsRepository(
                clientAPI: apiMock,
                dataBase: dataBaseMock
            ),
            catId: ""
        )
        
        XCTAssertEqual(viewModel.cat.breedName, "Invalid Data")
    }
    
    func test_onInit_ifAValidIdIsGiven_itReturnsAValidCat() {
        
        viewModel = CatDetailViewModel(
            repository: CatsRepository(
                clientAPI: apiMock,
                dataBase: dataBaseMock
            ),
            catId: "1"
        )
        
        XCTAssertEqual(viewModel.cat.breedName, "Valid Cat")
    }
}
