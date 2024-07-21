import Foundation
import CatifyUI
import CatifyDB
import CatifyAPI

@Observable
class CatsListViewModel {
    
    enum CatsFilter {
        case all
        case favorites
    }
    
    private let repository: CatsRepository
    private(set) var allImageItems: [ImageItem] = []
    private(set) var imageItems: [ImageItem] = []
    private var page = 1
    var isFetching = false
    let filter: CatsFilter
    var searchQuery = "" {
        didSet {
            filterItems()
        }
    }
    
    init(repository: CatsRepository,
         filter: CatsFilter = .all,
         imageItems: [ImageItem] = []) {
        self.repository = repository
        self.filter = filter
        self.imageItems = imageItems
        self.allImageItems = imageItems
    }
    
    @MainActor
    func fetchData() async {
        
        guard searchQuery.isEmpty else { return }
        
        switch filter {
        case .all:
            await fetchRemoteCats()
        case .favorites:
            fetchFavoriteCats()
        }
    }
    
    func fetchRemoteCats() async {
        guard !isFetching else { return }
    
        isFetching = true

        await repository.fetchRemoteCats(page: page)
        page += 1
        imageItems = repository.fetchLocalCats()
        allImageItems = imageItems
        
        isFetching = false
    }
    
    func fetchFavoriteCats() {
        imageItems = repository.fetchLocalCats(favoritesOnly: true)
        allImageItems = imageItems
    }
    
    func filterItems() {
        if searchQuery.isEmpty {
            imageItems = allImageItems
        } else {
            imageItems = allImageItems.filter {
                $0.text.contains(searchQuery)
            }
        }
    }
    
    func toggleFavorite(for id: String) {
        repository.toggleFavorite(for: id)
        if filter == .favorites {
            fetchFavoriteCats()
        }
    }
    
    func didSelectCat(id: String) {
        
    }
}
