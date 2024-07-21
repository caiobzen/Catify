import SwiftUI
import CatifyDB

@Observable
class CatDetailViewModel {
    
    private enum Constants {
        static let origin = "Origin"
        static let temperament = "Temperament"
        static let description = "Description"
    }
    
    struct CatInfoSection: Equatable {
        let header: String
        let text: String
    }
    
    private let repository: CatsRepository
    var cat: Cat
    var catInfoSections: [CatInfoSection] = []
    
    init(repository: CatsRepository,
         catId: String) {
        self.repository = repository
        self.cat = self.repository.fetchCatWith(id: catId)
        
        setupSections()
    }
    
    private func setupSections() {
        cat.origin.flatMap { catInfoSections.append(CatInfoSection(header: Constants.origin, text: $0)) }
        cat.temperament.flatMap { catInfoSections.append(CatInfoSection(header: Constants.temperament, text: $0)) }
        cat.desc.flatMap { catInfoSections.append(CatInfoSection(header: Constants.description, text: $0)) }
    }
}
