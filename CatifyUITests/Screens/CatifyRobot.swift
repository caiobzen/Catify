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
    
    func dismissView() {
        app.buttons.firstMatch.tap()
    }
}
