import Foundation

public protocol CatifyAPIProtocol {
    
    func fetchCatImages(size: ImageSize,
                        page: Int,
                        limit: Int,
                        hasBreeds: Bool,
                        includeBreeds: Bool) async throws -> [CatImage]
}
