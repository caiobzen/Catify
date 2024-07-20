@testable import CatifyAPI
import Foundation

class CatifyAPIMock: CatifyAPIProtocol {
    
    var fetchCatImagesResponse: [CatImage] = []
    var requestedPage: Int?
    
    func fetchCatImages(
        size: CatifyAPI.ImageSize,
        page: Int,
        limit: Int,
        hasBreeds: Bool,
        includeBreeds: Bool
    ) async throws -> [CatifyAPI.CatImage] {
        
        requestedPage = page
        return fetchCatImagesResponse
    }
}
