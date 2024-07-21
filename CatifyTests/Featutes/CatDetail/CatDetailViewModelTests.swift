import XCTest
@testable import Catify

final class CatDetailViewModelTests: XCTestCase {
    
    private var apiMock: CatifyAPIMock!
    private var dataBaseMock: CatifyDataBaseMock!
    private var viewModel: CatDetailViewModel!
    
    override func setUp() {
        apiMock = CatifyAPIMock()
        dataBaseMock = CatifyDataBaseMock()
        viewModel = CatDetailViewModel(
            repository: CatsRepository(
                clientAPI: apiMock,
                dataBase: dataBaseMock
            ),
            catId: "1"
        )
    }

    func test_onInit_ifAnInvalidIdIsGiven_itReturnsAnInvalidCat() {
        
        // Arrange, Act
        viewModel = CatDetailViewModel(
            repository: CatsRepository(
                clientAPI: apiMock,
                dataBase: dataBaseMock
            ),
            catId: ""
        )
        
        // Assert
        XCTAssertEqual(viewModel.cat.breedName, "Invalid Data")
    }
    
    func test_onInit_ifAValidIdIsGiven_itReturnsAValidCat() {
        
        // Assert
        XCTAssertEqual(viewModel.cat.breedName, "Valid Cat")
    }
    
    func test_onInit_itLoadsCatInfoSections() {
        
        // Assert
        XCTAssertEqual(viewModel.catInfoSections, [
            CatDetailViewModel.CatInfoSection(header: "Origin", text: "Cat Origin"),
            CatDetailViewModel.CatInfoSection(header: "Temperament", text: "Cat Temperament"),
            CatDetailViewModel.CatInfoSection(header: "Description", text: "Cat Description")
        ])
    }
}
