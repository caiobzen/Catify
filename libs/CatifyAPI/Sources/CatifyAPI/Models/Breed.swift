import Foundation

public struct Breed: Codable, Equatable {
    
    public let id: String
    public let name: String
    public let origin: String
    public let temperament: String
    public let lifespan: String
    public let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case origin
        case temperament
        case lifespan = "life_span"
        case description
    }
    
    public init(id: String, 
                name: String,
                origin: String,
                temperament: String,
                lifespan: String,
                description: String) {
        self.id = id
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.lifespan = lifespan
        self.description = description
    }
}
