import Foundation

public struct CatImage: Codable, Equatable {
    
    public let id: String
    public let url: URL
    public let width: Int
    public let height: Int
    public let breeds: [Breed]
    
    public init(id: String,
                url: URL,
                width: Int,
                height: Int,
                breeds: [Breed]) {
        self.id = id
        self.url = url
        self.width = width
        self.height = height
        self.breeds = breeds
    }
}
