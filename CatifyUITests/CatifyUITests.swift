import XCTest

final class CatifyUITests: XCTestCase {
    
    var robot: CatifyRobot!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        robot = CatifyRobot(app: XCUIApplication())
        app.launchArguments.append("UITesting")
        app.launch()
        robot.waitCatsListToAppear()
    }
    
    func test_onSearchingForAValidBreed_ItFiltersTheList() throws {
        robot
            .searchBy(text: "Abyss")
            .expectNumberOfCells(toBe: 13)
    }
    
    func test_onSearchingForAnInvalidBreed_ItShowsAMessage() throws {
        robot
            .searchBy(text: "dog")
            .waitForNoBreedResultsToAppear()
            .expectNoBreedResultsText(toBe: "No breed named \"dog\"")
    }
    
    func test_onFavoritingACat_itTogglesTheFavoriteButton_andGoesToFavoritesScreen() {
        robot
            .favoriteFirstCat()
            .tapOnFavoritesTab()
            .waitCatsListToAppear()
            .expectNumberOfCats(toBe: 1)
            .favoriteFirstCat()
            .expectNumberOfCats(toBe: 0)
    }
    
    func test_catDetailsScreen_hasAllTheRequiredInformation() {
        robot
            .selectFirstCat()
            .expectDetailInformationsToExist()
    }
    
    func test_catDetailsScreen_canFavoriteACat() {
        robot
            .selectFirstCat()
            .favoriteFirstCat()
            .dismissView()
            .tapOnFavoritesTab()
            .expectNumberOfCats(toBe: 1)
            .favoriteFirstCat()
            .expectNumberOfCats(toBe: 0)
    }
}
