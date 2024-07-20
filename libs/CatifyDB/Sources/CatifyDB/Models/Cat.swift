import Foundation
import SwiftData

@Model
public class Cat: Identifiable {

    @Attribute(.unique)
    public let id: String
    public let image: URL?
    public let breedName: String?
    public let origin: String?
    public let temperament: String?
    public let lifespan: String?
    public let desc: String?
    public var isFavorite: Bool

    public init(id: String,
                image: URL?,
                breedName: String?,
                origin: String?,
                temperament: String?,
                lifespan: String?,
                desc: String?,
                isFavorite: Bool = false) {
        self.id = id
        self.image = image
        self.breedName = breedName ?? ""
        self.origin = origin ?? ""
        self.temperament = temperament ?? ""
        self.lifespan = lifespan ?? ""
        self.desc = desc ?? ""
        self.isFavorite = isFavorite
    }
}
