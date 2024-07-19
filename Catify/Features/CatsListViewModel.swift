import Foundation
import CatifyUI
import CatifyAPI

@Observable
class CatsListViewModel {
    
    private let clientAPI: CatifyAPIProtocol
    private var allImageItems: [ImageItem] = []
    private(set) var imageItems: [ImageItem] = []
    var searchQuery = "" {
        didSet {
            filterItems()
        }
    }
    
    init(clientAPI: CatifyAPIProtocol,
         imageItems: [ImageItem] = []) {
        self.clientAPI = clientAPI
        self.allImageItems = imageItems
        self.imageItems = imageItems
    }
    
    func fetchData() async {
        do {
            imageItems = try await clientAPI.fetchCatImages(
                size: .med,
                page: 1,
                limit: 10,
                hasBreeds: true,
                includeBreeds: true
            )
            allImageItems = imageItems
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
}
