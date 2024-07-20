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
                        repository: CatsRepository(
                            clientAPI: core.apiClient,
                            dataBase: core.dataBase
                        )
                    )
                )
                .tabItem {
                    Label("Cats", systemImage: "cat")
                }
                
                CatsListView(
                    viewModel: CatsListViewModel(
                        repository: CatsRepository(clientAPI: core.apiClient, dataBase: core.dataBase),
                        filter: .favorites)
                )
                    .tabItem {
                        Label("Favotites", systemImage: "star")
                    }
            }
        }
    }
}
