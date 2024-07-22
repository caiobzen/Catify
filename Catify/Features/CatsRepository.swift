import Foundation
import CatifyUI
import CatifyDB
import CatifyAPI

class CatsRepository {
    
    private enum Constants {
        static let limitPerPage = 15
    }
    
    private let clientAPI: CatifyAPIProtocol
    private let dataBase: CatifyDataBaseProtocol
    
    init(clientAPI: CatifyAPIProtocol,
         dataBase: CatifyDataBaseProtocol) {
        self.clientAPI = clientAPI
        self.dataBase = dataBase
    }
    
    func fetchRemoteCats(page: Int) async {
        do {
            let catImages = try await clientAPI.fetchCatImages(
                size: .thumb,
                page: page,
                limit: Constants.limitPerPage,
                hasBreeds: true,
                includeBreeds: true,
                order: .asc
            )
            saveCats(catImages)
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func saveCats(_ cats: [CatImage]) {
        cats.forEach {
            dataBase.insert(cat: Cat(
                id: $0.id,
                image: $0.url,
                breedName: $0.breeds.first?.name ?? "",
                origin: $0.breeds.first?.origin ?? "",
                temperament: $0.breeds.first?.temperament ?? "",
                lifespan: $0.breeds.first?.lifespan ?? "",
                desc: $0.breeds.first?.description ?? "",
                isFavorite: false))
        }
    }
    
    func fetchLocalCats(favoritesOnly: Bool = false) -> [ImageItem] {
        dataBase.fetchCats(favoritesOnly: favoritesOnly)
    }
    
    func toggleFavorite(for id: String) {
        dataBase.toggleFavorite(catId: id)
    }
    
    func fetchCatWith(id: String) -> Cat {
        dataBase.fetchCatWith(id: id) ?? Cat(id: "", 
                                             image: nil,
                                             breedName: "Invalid Data",
                                             origin: "",
                                             temperament: nil,
                                             lifespan: nil,
                                             desc: nil)
    }
}
