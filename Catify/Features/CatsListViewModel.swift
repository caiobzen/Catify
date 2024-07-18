import Foundation
import CatifyUI
import CatifyAPI

@Observable
class CatsListViewModel {
    
    private let clientAPI: CatifyAPIProtocol
    init(clientAPI: CatifyAPIProtocol, 
         imageItems: [ImageItem] = []) {
        self.clientAPI = clientAPI
        self.imageItems = imageItems
    }
    
    private(set) var imageItems: [ImageItem] = []
    
    func fetchData() async {
        do {
            imageItems = try await clientAPI.fetchCatImages(
                size: .med,
                page: 1,
                limit: 10,
                hasBreeds: true,
                includeBreeds: true
            )
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
}
