import Foundation
import CatifyAPI

struct AppCore {

    private enum Constants {
        static let catsAPIKey = "CATS_API_KEY"
    }
    
    var apiClient: CatifyAPIProtocol = {
        let apiKey = Bundle.main.infoDictionary?[Constants.catsAPIKey] as? String
        guard let apiKey else { fatalError("Missing Cats API key") }
        return CatifyAPIClient(apiKey: apiKey)
    }()
}
