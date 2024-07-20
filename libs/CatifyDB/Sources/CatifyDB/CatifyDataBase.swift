import SwiftData
import Foundation

public protocol CatifyDataBaseProtocol {
    func fetchCats() -> [Cat]
    func insert(cat: Cat)
    func deleteAllCats()
    func toggleFavorite(catId: String)
}

public class CatifyDataBase: CatifyDataBaseProtocol {
    
    private var modelContainer: ModelContainer!
    
    public init() throws {
        modelContainer = try ModelContainer(for: Cat.self)
    }
    
    @MainActor
    public func fetchCats() -> [Cat] {
        (try? modelContainer.mainContext.fetch(FetchDescriptor<Cat>())) ?? []
    }
    
    @MainActor
    public func insert(cat: Cat) {
        modelContainer.mainContext.insert(cat)
        try? modelContainer.mainContext.save()
    }
    
    @MainActor
    public func deleteAllCats() {
        fetchCats().forEach {
            modelContainer.mainContext.delete($0)
        }
        try? modelContainer.mainContext.save()
    }
    
    @MainActor
    public func toggleFavorite(catId: String) {
        let catToUpdate = FetchDescriptor<Cat>(
            predicate: #Predicate<Cat> { $0.id == catId }
        )

        let cats = try? modelContainer.mainContext.fetch(catToUpdate)
        cats?.first?.isFavorite.toggle()
        try? modelContainer.mainContext.save()
    }
}
