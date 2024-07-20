@testable import CatifyDB
import Foundation

class CatifyDataBaseMock: CatifyDataBaseProtocol {
    var cats: [Cat] = [
        Cat(id: "1",
            image: nil,
            breedName: nil,
            origin: nil,
            temperament: nil,
            lifespan: nil,
            desc: nil,
            isFavorite: true),
        Cat(id: "1",
            image: nil,
            breedName: nil,
            origin: nil,
            temperament: nil,
            lifespan: nil,
            desc: nil,
            isFavorite: false)
    ]
    
    func fetchCats(favoritesOnly: Bool) -> [CatifyDB.Cat] { favoritesOnly ? cats.filter { $0.isFavorite } : cats }
    func insert(cat: CatifyDB.Cat) { cats.append(cat) }
    func deleteAllCats() { cats.removeAll() }
    func toggleFavorite(catId: String) {
        (cats.first { $0.id == catId })?.isFavorite.toggle()
    }
}
