import Foundation
import CatifyUI
import CatifyDB
import CatifyAPI

@Observable
class CatsListViewModel {
    
    private let clientAPI: CatifyAPIProtocol
    private let dataBase: CatifyDataBaseProtocol
    private var allImageItems: [ImageItem] = []
    private(set) var imageItems: [ImageItem] = []
    private var page = 1
    var searchQuery = "" {
        didSet {
            filterItems()
        }
    }
    
    init(clientAPI: CatifyAPIProtocol,
         dataBase: CatifyDataBaseProtocol,
         imageItems: [ImageItem] = []) {
        self.clientAPI = clientAPI
        self.dataBase = dataBase
        self.allImageItems = imageItems
        self.imageItems = imageItems
    }
    
    func fetchData() async {
        do {
            let catImages = try await clientAPI.fetchCatImages(
                size: .med,
                page: page,
                limit: 25,
                hasBreeds: true,
                includeBreeds: true
            )
            
            saveCats(catImages)
            imageItems = dataBase.fetchCats()
            allImageItems = imageItems
            page += 1
        } catch {
            print("error \(error.localizedDescription)")
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
