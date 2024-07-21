import SwiftUI
import CatifyDB

@Observable
class CatDetailViewModel {
    private let repository: CatsRepository
    var cat: Cat
    
    init(repository: CatsRepository,
         catId: String) {
        self.repository = repository
        self.cat = self.repository.fetchCatWith(id: catId)
    }
}
