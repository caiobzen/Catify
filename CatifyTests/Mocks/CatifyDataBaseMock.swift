@testable import CatifyDB
import Foundation

class CatifyDataBaseMock: CatifyDataBaseProtocol {
    
    var didFetchCats = false
    
    var cats: [Cat] = [
        Cat(id: "1",
            image: nil,
            breedName: "Valid Cat",
            origin: "Cat Origin",
            temperament: "Cat Temperament",
            lifespan: nil,
            desc: "Cat Description",
            isFavorite: true),
        Cat(id: "2",
            image: nil,
            breedName: "Valid Cat",
            origin: nil,
            temperament: nil,
            lifespan: nil,
            desc: nil,
            isFavorite: false)
    ]
    
    func fetchCats(favoritesOnly: Bool) -> [Cat] {
        didFetchCats = true
        return favoritesOnly ? cats.filter { $0.isFavorite } : cats
    }
    func insert(cat: Cat) { cats.append(cat) }
    func deleteAllCats() { cats.removeAll() }
    func toggleFavorite(catId: String) {
        (cats.first { $0.id == catId })?.isFavorite.toggle()
    }
    func fetchCatWith(id: String) -> Cat? {
        (cats.first { $0.id == id })
    }
}
