@testable import CatifyAPI
import Foundation

class CatifyAPIMock: CatifyAPIProtocol {
    
    var error: APIClientError? = nil
    var fetchCatImagesResponse: [CatImage] = []
    var requestedPage: Int?
    
    func fetchCatImages(
        size: CatifyAPI.ImageSize,
        page: Int,
        limit: Int,
        hasBreeds: Bool,
        includeBreeds: Bool,
        order: Order
    ) async throws -> [CatifyAPI.CatImage] {
        
        if let error {
            throw error
        }

        requestedPage = page
        return fetchCatImagesResponse
    }
}
