import XCTest
@testable import Catify
@testable import CatifyAPI
@testable import CatifyDB
@testable import CatifyUI

final class CatsListViewModelTests: XCTestCase {
    
    private var apiMock: CatifyAPIMock!
    private var dataBaseMock: CatifyDataBaseMock!
    private var viewModel: CatsListViewModel!
    
    override func setUp() {
        apiMock = CatifyAPIMock()
        dataBaseMock = CatifyDataBaseMock()
        viewModel = CatsListViewModel(clientAPI: apiMock, dataBase: dataBaseMock)
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
                                      dataBase: dataBaseMock,
                                      imageItems: imageItemsMock)
        
        // Act
        viewModel.searchQuery = ""
        
        // Assert
        XCTAssertEqual(viewModel.imageItems.count, 2)
    }
    
    func test_whenSeachingForABreed_itFiltersTheList() {
        
        // Arrange
        viewModel = CatsListViewModel(clientAPI: apiMock,
                                      dataBase: dataBaseMock,
                                      imageItems: imageItemsMock)
        
        // Act
        viewModel.searchQuery = "foo"
        
        // Assert
        XCTAssertEqual(viewModel.imageItems.count, 1)
    }
}

extension CatsListViewModelTests {
    
    var imageItemsMock: [ImageItem] {[
        Cat(id: "1",
            image: URL(string: "http://cat.com")!,
            breedName: "foo",
            origin: "",
            temperament: "",
            desc: "",
            isFavorite: false),
        Cat(id: "2",
            image: URL(string: "http://cat.com")!,
            breedName: "bar",
            origin: "",
            temperament: "",
            desc: "",
            isFavorite: true)
    ]}
}
