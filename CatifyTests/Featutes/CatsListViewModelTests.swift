import XCTest
@testable import Catify
@testable import CatifyUI
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
    
    func test_whenSeachingWithEmptyString_itDisplaysAllImageItems() {
        
        // Arrange
        viewModel = CatsListViewModel(clientAPI: apiMock,
                                      imageItems: imageItemsMock)
        
        // Act
        viewModel.searchQuery = ""
        
        // Assert
        XCTAssertEqual(viewModel.imageItems.count, 2)
    }
    
    func test_whenSeachingForABreed_itFiltersTheList() {
        
        // Arrange
        viewModel = CatsListViewModel(clientAPI: apiMock,
                                      imageItems: imageItemsMock)
        
        // Act
        viewModel.searchQuery = "foo"
        
        // Assert
        XCTAssertEqual(viewModel.imageItems.count, 1)
    }
}

extension CatsListViewModelTests {
    
    var imageItemsMock: [ImageItem] {  [
        CatImage(id: "",
                 url: URL(string: "http://cat.com")!,
                 width: 0,
                 height: 0,
                 breeds: [
                    .init(id: "",
                          name: "foo",
                          origin: "",
                          temperament: "",
                          description: "")
                 ]),
        CatImage(id: "",
                 url: URL(string: "http://cat.com")!,
                 width: 0,
                 height: 0,
                 breeds: [
                    .init(id: "",
                          name: "bar",
                          origin: "",
                          temperament: "",
                          description: "")
                 ])
    ]}
}
