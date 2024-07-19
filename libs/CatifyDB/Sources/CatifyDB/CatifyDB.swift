import SwiftData
import Foundation

public protocol CatifyDataBaseProtocol {
    func fetchCats() -> [Cat]
    func insert(cat: Cat)
    func deleteAllCats()
    func toggleFavorite(catId: String)
}

class CatifyDB: CatifyDataBaseProtocol {
    
    private var modelContainer: ModelContainer!
    
    public init() throws {
        modelContainer = try ModelContainer(for: Cat.self)
    }
    
    @MainActor
    public func fetchCats() -> [Cat] {
        return (try? modelContainer.mainContext.fetch(FetchDescriptor<Cat>())) ?? []
    }
    
    @MainActor
    public func insert(cat: Cat) {
        modelContainer.mainContext.insert(cat)
    }
    
    @MainActor
    public func deleteAllCats() {
        fetchCats().forEach {
            modelContainer.mainContext.delete($0)
        }
    }
    
    @MainActor
    public func toggleFavorite(catId: String) {
        let catToUpdate = FetchDescriptor<Cat>(
            predicate: #Predicate<Cat> { cat in
                cat.id == catId
            }
        )

        let cats = try? modelContainer.mainContext.fetch(catToUpdate)
        cats?.first?.isFavorite.toggle()
    }
}
