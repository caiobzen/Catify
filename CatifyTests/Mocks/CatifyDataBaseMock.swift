@testable import CatifyDB
import Foundation

class CatifyDataBaseMock: CatifyDataBaseProtocol {
    var cats: [Cat] = []
    
    func fetchCats() -> [CatifyDB.Cat] { cats }
    func insert(cat: CatifyDB.Cat) { cats.append(cat) }
    func deleteAllCats() { cats.removeAll() }
    func toggleFavorite(catId: String) {
        (cats.first { $0.id == catId })?.isFavorite.toggle()
    }
}
