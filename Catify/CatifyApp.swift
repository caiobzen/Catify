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
                CatsListView(
                    viewModel: CatsListViewModel(
                        clientAPI: core.apiClient,
                        dataBase: core.dataBase
                    )
                )
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
