import SwiftUI
import SwiftData
import CatifyAPI
import CatifyUI

@main
struct CatifyApp: App {
    
    private let core = AppCore()
    
    var body: some Scene {
        
        WindowGroup {
            ImageItemListView(imageItems: [
                CatImage(id: "",
                         url: URL(string: "https://cdn2.thecatapi.com/images/xBR2jSIG7.jpg")!,
                         width: 100,
                         height: 100, 
                         breeds: [
                            Breed(id: "", name: "cat", origin: "", temperament: "", description: "")
                         ])
            ])
        }
    }
}

extension CatImage: ImageItem {
    public var imageURL: URL { self.url }
    public var text: String { self.breeds.first?.name ?? "cat" }
}
