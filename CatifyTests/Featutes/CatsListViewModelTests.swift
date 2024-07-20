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
        viewModel = CatsListViewModel(
            repository: CatsRepository(
                clientAPI: apiMock,
                dataBase: dataBaseMock
            ),
            imageItems: imageItemsMock
        )
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
    
    func test_increasePagination() async {

        // Arrange, Act
        await viewModel.fetchData()
        await viewModel.fetchData()
        
        // Assert
        XCTAssertEqual(apiMock.requestedPage, 2)
    }
    
    func test_whenSeachingWithEmptyString_itDisplaysAllImageItems() {
        
        // Arrange, Act
        viewModel.searchQuery = ""
        
        // Assert
        XCTAssertEqual(viewModel.imageItems.count, 2)
    }
    
    func test_whenSeachingForABreed_itFiltersTheList() {
        
        // Arrange, Act
        viewModel.searchQuery = "foo"
        
        // Assert
        XCTAssertEqual(viewModel.imageItems.count, 1)
    }
    
    func test_whenFilteringByFavorites_itDisplaysSavedCatsOnly() async {
        
        // Arrange, Act
        viewModel = CatsListViewModel(
            repository: CatsRepository(
                clientAPI: apiMock,
                dataBase: dataBaseMock
            ),
            filter: .favorites,
            imageItems: imageItemsMock
        )
        
        await viewModel.fetchData()
        
        // Assert
        XCTAssertEqual(viewModel.imageItems.count, 1)
    }
}

extension CatsListViewModelTests {
    
    struct ImageItemMock: ImageItem {
        var id: String
        var text: String
        var imageURL: URL
        var isFavorite: Bool
    }
    
    var imageItemsMock: [ImageItem] {[
        ImageItemMock(id: "1",
            text: "foo",
            imageURL: URL(string: "http://cat.com")!,
            isFavorite: false),
        ImageItemMock(id: "2",
            text: "bar",
            imageURL: URL(string: "http://cat.com")!,
            isFavorite: true),
    ]}
}


