import Foundation

public protocol CatifyAPIProtocol {
    
    func fetchCatImages(size: ImageSize,
                        page: Int,
                        limit: Int,
                        hasBreeds: Bool,
                        includeBreeds: Bool,
                        order: Order) async throws -> [CatImage]
}
