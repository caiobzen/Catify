import Foundation
import SwiftData

@Model
public class Cat: Identifiable {

    @Attribute(.unique)
    public let id: String
    public let image: URL
    @Attribute(.unique)
    public let breedName: String
    public let origin: String
    public let temperament: String
    public let desc: String
    public var isFavorite: Bool

    public init(id: String, 
                image: URL,
                breedName: String,
                origin: String, 
                temperament: String,
                desc: String,
                isFavorite: Bool) {
        self.id = id
        self.image = image
        self.breedName = breedName
        self.origin = origin
        self.temperament = temperament
        self.desc = desc
        self.isFavorite = isFavorite
    }
}
