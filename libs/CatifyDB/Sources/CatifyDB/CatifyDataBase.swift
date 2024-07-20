import SwiftData
import Foundation

public protocol CatifyDataBaseProtocol {
    func fetchCats(favoritesOnly: Bool) -> [Cat]
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
    public func fetchCats(favoritesOnly: Bool = false) -> [Cat] {
        
        var fetchDescriptor = FetchDescriptor<Cat>()
        
        if favoritesOnly {
            fetchDescriptor = FetchDescriptor<Cat>(
                predicate: #Predicate<Cat> { $0.isFavorite }
            )
        }
        
        return (try? modelContainer.mainContext.fetch(fetchDescriptor)) ?? []
    }
    
    @MainActor
    public func insert(cat: Cat) {
        
        if fetchCats().contains(where: { $0.id == cat.id }) {
            return
        }
        
        modelContainer.mainContext.insert(cat)
        do {
            try modelContainer.mainContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
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
