import Foundation
import XCTest

struct CatifyRobot {
    
    private enum Constants {
        enum Label {
            static let imageItemList = "ImageItemListView"
            static let searchTextField = "SearchTextField"
            static let imageItemView = "ImageItemView"
            static let favoriteButton = "FavoriteButton"
            static let favoriteIcon = "FavoriteIcon"
            static let favoritesTab = "Favorites"
            static let catImage = "CatImage"
        }
    }
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    var catsList: XCUIElement! {
        app.scrollViews[Constants.Label.imageItemList]
    }
    
    var searchTextField: XCUIElement! {
        app.textFields[Constants.Label.searchTextField]
    }
    
    var cells: XCUIElementQuery {
        app.staticTexts.matching(identifier: Constants.Label.imageItemView)
    }
    
    var noBreedResults: XCUIElement {
        app.staticTexts["NoBreedResults"]
    }
    
    var favoriteButtons: XCUIElement {
        app.buttons[Constants.Label.favoriteButton]
    }
    
    var favoritesTab: XCUIElement {
        app.buttons[Constants.Label.favoritesTab]
    }
    
    var catImages: XCUIElementQuery {
        app.images.matching(identifier: Constants.Label.imageItemView)
    }
    
    var catImage: XCUIElement {
        app.images.matching(identifier: Constants.Label.catImage).firstMatch
    }
    
    var screenTexts: XCUIElementQuery {
        app.staticTexts
    }
}

// MARK: - Actions
extension CatifyRobot {
    
    @discardableResult
    func dismissView() -> Self {
        app.buttons.firstMatch.tap()
        return self
    }
    
    @discardableResult
    func searchBy(text: String) -> Self {
        searchTextField.tap()
        searchTextField.typeText(text)
        return self
    }
    
    @discardableResult
    func favoriteFirstCat() -> Self {
        favoriteButtons.firstMatch.tap()
        return self
    }
    
    @discardableResult
    func tapOnFavoritesTab() -> Self {
        favoritesTab.tap()
        return self
    }
    
    @discardableResult
    func selectFirstCat() -> Self {
        catImages.firstMatch.tap()
        return self
    }
}

// MARK: - Expections
extension CatifyRobot {

    @discardableResult
    func expectNumberOfCells(toBe expectedNumberOfCells: Int, 
                             file: StaticString = #file,
                             line: UInt = #line) -> Self {
        XCTAssertEqual(cells.count, expectedNumberOfCells, file: file, line: line)
        return self
    }
    
    @discardableResult
    func expectNumberOfCats(toBe expectedNumberOfCats: Int,
                            file: StaticString = #file,
                            line: UInt = #line) -> Self {
        XCTAssertEqual(catImages.count, expectedNumberOfCats, file: file, line: line)
        return self
    }
    
    @discardableResult
    func waitForNoBreedResultsToAppear(file: StaticString = #file,
                                       line: UInt = #line) -> Self {
        let exists = noBreedResults.waitForExistence(timeout: 2)
        XCTAssertTrue(exists, file: file, line: line)
        return self
    }
    
    @discardableResult
    func expectNoBreedResultsText(toBe text: String,
                                  file: StaticString = #file,
                                  line: UInt = #line) -> Self {
        XCTAssertEqual(noBreedResults.label, text, file: file, line: line)
        return self
    }
    
    @discardableResult
    func waitCatsListToAppear(file: StaticString = #file,
                              line: UInt = #line) -> Self {
        let exists = catsList.waitForExistence(timeout: 10)
        XCTAssertTrue(exists, file: file, line: line)
        return self
    }
    
    @discardableResult
    func expectDetailInformationsToExist(file: StaticString = #file,
                                         line: UInt = #line) -> Self {
        let imageExists = catImage.waitForExistence(timeout: 1)
        let originExists = screenTexts["Origin"].waitForExistence(timeout: 0.1)
        let temperamentExists = screenTexts["Temperament"].waitForExistence(timeout: 0.1)
        let descriptionExists = screenTexts["Description"].waitForExistence(timeout: 0.1)
        
        XCTAssertTrue(imageExists, file: file, line: line)
        XCTAssertTrue(originExists, file: file, line: line)
        XCTAssertTrue(temperamentExists, file: file, line: line)
        XCTAssertTrue(descriptionExists, file: file, line: line)
        return self
    }
}
