import SwiftUI
import SwiftData
import CatifyAPI

@main
struct CatifyApp: App {
    
    private let core = AppCore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
