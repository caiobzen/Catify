import SwiftUI
import SwiftData
import CatifyAPI
import CatifyUI

@main
struct CatifyApp: App {
    
    private let core = AppCore()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Text("Cats")
                    .tabItem {
                        Label("Cats", systemImage: "cat")
                    }
                
                Text("Favotites")
                    .tabItem {
                        Label("Favotites", systemImage: "star")
                    }
            }
        }
    }
}
