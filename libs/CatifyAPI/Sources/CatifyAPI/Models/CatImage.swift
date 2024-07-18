import Foundation

public struct CatImage: Codable, Equatable {
    let id: String
    let url: URL
    let width: Int
    let height: Int
    let breeds: [Breed]
}
