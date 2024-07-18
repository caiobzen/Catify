import XCTest
@testable import Catify
@testable import CatifyAPI

final class CatsListViewModelTests: XCTestCase {
    
    private var apiMock: CatifyAPIMock!
    
    override func setUp() {
        apiMock = CatifyAPIMock()
    }
    
    func test_viewModelHasAListOfImageItems() {
        
        // Arrange, Act
        let viewModel = CatsListViewModel(clientAPI: apiMock)
        
        // Assert
        XCTAssertTrue(viewModel.imageItems.isEmpty)
    }
    
    func test_onFetchCats_imageItemsGetsPopulated() async {
        
        // Arrange
        let viewModel = CatsListViewModel(clientAPI: apiMock)
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


