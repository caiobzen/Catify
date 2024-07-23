import XCTest

final class CatifyUITests: XCTestCase {
    
    var robot: CatifyRobot!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        robot = CatifyRobot(app: XCUIApplication())
        app.launch()
        
        let _ = robot.catsList.waitForExistence(timeout: 10)
    }
    
    func test_onSearchingForAValidBreed_ItFiltersTheList() throws {
        
        robot.searchTextField.tap()
        robot.searchTextField.typeText("Abyss")
        XCTAssertEqual(robot.cells.count, 13)
    }
    
    func test_onSearchingForAnInvalidBreed_ItShowsAMessage() throws {
        
        robot.searchTextField.tap()
        robot.searchTextField.typeText("dog")
        let exists = robot.noBreedResults.waitForExistence(timeout: 2)
        XCTAssertTrue(exists)
        XCTAssertEqual(robot.noBreedResults.label, "No breed named \"dog\"")
    }
    
    func test_onFavoritingACat_itTogglesTheFavoriteButton_andGoesToFavoritesScreen() {
        
        let firstFavoriteButton = robot.favoriteButtons.firstMatch
        firstFavoriteButton.tap()
        
        robot.favoritesTab.tap()
        
        let _ = robot.catsList.waitForExistence(timeout: 10)
        XCTAssertEqual(robot.catImages.count, 1)
        firstFavoriteButton.tap()
        XCTAssertEqual(robot.catImages.count, 0)
    }
    
    func test_catDetailsScreen_hasAllTheRequiredInformation() {
        robot.catImages.firstMatch.tap()
        
        let imageExists = robot.catImage.waitForExistence(timeout: 1)
        let originExists = robot.screenTexts["Origin"].waitForExistence(timeout: 0.1)
        let temperamentExists = robot.screenTexts["Temperament"].waitForExistence(timeout: 0.1)
        let descriptionExists = robot.screenTexts["Description"].waitForExistence(timeout: 0.1)
        
        XCTAssertTrue(imageExists)
        XCTAssertTrue(originExists)
        XCTAssertTrue(temperamentExists)
        XCTAssertTrue(descriptionExists)
    }
    
    func test_catDetailsScreen_canFavoriteACat() {
        robot.catImages.firstMatch.tap()
        
        robot.favoriteButtons.firstMatch.tap()
        robot.dismissView()
        robot.favoritesTab.tap()
        
        XCTAssertEqual(robot.catImages.count, 1)
        robot.favoriteButtons.firstMatch.tap()
        XCTAssertEqual(robot.catImages.count, 0)
    }
}
