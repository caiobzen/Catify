import XCTest
@testable import Catify
@testable import CatifyAPI

final class CatsListViewModelTests: XCTestCase {
    
    private var apiMock: CatifyAPIMock!
    private var viewModel: CatsListViewModel!
    
    override func setUp() {
        apiMock = CatifyAPIMock()
        viewModel = CatsListViewModel(clientAPI: apiMock)
    }
    
    func test_OnInitViewModelHasAnEmptyListOfImageItems() {
        XCTAssertTrue(viewModel.imageItems.isEmpty)
    }
    
    func test_onFetchCats_imageItemsGetsPopulated() async {
        
        // Arrange
        apiMock.fetchCatImagesResponse = [
            .init(id: "",
                  url: URL(string: "https://cdn2.thecatapi.com/images/xBR2jSIG7.jpg")!,
                  width: 0,
                  height: 0,
                  breeds: [])
        ]
        
        // Act
        await viewModel.fetchData()
        
        // Assert
        XCTAssertFalse(viewModel.imageItems.isEmpty)
    }
}


