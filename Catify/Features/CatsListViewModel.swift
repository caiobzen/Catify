import Foundation
import CatifyUI
import CatifyDB
import CatifyAPI

@Observable
class CatsListViewModel {
    
    private let clientAPI: CatifyAPIProtocol
    private let dataBase: CatifyDataBaseProtocol
    private let showFavoritesOnly: Bool
    private var allImageItems: [ImageItem] = []
    private(set) var imageItems: [ImageItem] = []
    private var page = 1
    var isFetching = false
    var searchQuery = "" {
        didSet {
            filterItems()
        }
    }
    
    init(clientAPI: CatifyAPIProtocol,
         dataBase: CatifyDataBaseProtocol,
         showFavoritesOnly: Bool = false,
         imageItems: [ImageItem] = []) {
        self.clientAPI = clientAPI
        self.dataBase = dataBase
        self.allImageItems = imageItems
        self.showFavoritesOnly = showFavoritesOnly
        self.imageItems = showFavoritesOnly
            ? dataBase.fetchCats(favoritesOnly: true)
            : imageItems
    }
    
    @MainActor
    func fetchData() async {
        guard !isFetching else { return }
        
        if showFavoritesOnly {
            imageItems = dataBase.fetchCats(favoritesOnly: showFavoritesOnly)
            allImageItems = imageItems
        } else {
            do {
                isFetching = true
                let catImages = try await clientAPI.fetchCatImages(
                    size: .med,
                    page: page,
                    limit: 25,
                    hasBreeds: true,
                    includeBreeds: true,
                    order: .asc
                )
                
                saveCats(catImages)
                imageItems = dataBase.fetchCats(favoritesOnly: showFavoritesOnly)
                allImageItems = imageItems
                page += 1
                isFetching = false
            } catch {
                print("error \(error.localizedDescription)")
                isFetching = false
            }
        }
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
        dataBase.toggleFavorite(catId: id)
        if showFavoritesOnly {
            imageItems = dataBase.fetchCats(favoritesOnly: showFavoritesOnly)
            allImageItems = imageItems
        }
    }
}

private extension CatsListViewModel {
    
    func saveCats(_ cats: [CatImage]) {
        cats.forEach {
            dataBase.insert(cat: Cat(
                id: $0.id,
                image: $0.url,
                breedName: $0.breeds.first?.name ?? "cat",
                origin: $0.breeds.first?.origin ?? "origin",
                temperament: $0.breeds.first?.temperament ?? "temperament",
                desc: $0.breeds.first?.description ?? "",
                isFavorite: false))
        }
    }
}
