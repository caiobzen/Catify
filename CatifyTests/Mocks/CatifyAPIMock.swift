@testable import CatifyAPI
import Foundation

class CatifyAPIMock: CatifyAPIProtocol {
    
    var fetchCatImagesResponse: [CatImage] = []
    
    func fetchCatImages(
        size: CatifyAPI.ImageSize,
        page: Int,
        limit: Int,
        hasBreeds: Bool,
        includeBreeds: Bool
    ) async throws -> [CatifyAPI.CatImage] {
        fetchCatImagesResponse
    }
}
