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
                ImageItem(
                    id: "foo",
                    text: "Cat",
                    imageURL: URL(string: "https://cdn2.thecatapi.com/images/xBR2jSIG7.jpg")!
                )
            ])
        }
    }
}
