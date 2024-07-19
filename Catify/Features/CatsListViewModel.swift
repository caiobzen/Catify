import Foundation
import CatifyUI
import CatifyAPI

@Observable
class CatsListViewModel {
    
    private let clientAPI: CatifyAPIProtocol
    private var allImageItems: [ImageItem] = [] // Store all items fetched from API
    private(set) var imageItems: [ImageItem] = [] // Store filtered items to be displayed
    
    init(clientAPI: CatifyAPIProtocol,
         imageItems: [ImageItem] = []) {
        self.clientAPI = clientAPI
        self.allImageItems = imageItems
        self.imageItems = allImageItems
    }
    
    func fetchData() async {
        do {
            allImageItems = try await clientAPI.fetchCatImages(
                size: .med,
                page: 1,
                limit: 10,
                hasBreeds: true,
                includeBreeds: true
            )
            imageItems = allImageItems
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func filterItems(queryString: String) {
        if queryString.isEmpty {
            imageItems = allImageItems
        } else {
            imageItems = allImageItems.filter {
                $0.text.contains(queryString)
            }
        }
    }
}
