import Foundation

public struct Breed: Codable, Equatable {
    
    public let id: String
    public let name: String
    public let origin: String
    public let temperament: String
    public let description: String
    
    public init(id: String, 
                name: String,
                origin: String,
                temperament: String,
                description: String) {
        self.id = id
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.description = description
    }
}
