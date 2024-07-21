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
                        ),
                        filter: .all
                    ),
                    onItemSelected: { catId in
                        print(catId)
                    }
                )
                .tabItem {
                    Label("Cats", systemImage: "cat")
                }
                
                CatsListView(
                    viewModel: CatsListViewModel(
                        repository: CatsRepository(
                            clientAPI: core.apiClient,
                            dataBase: core.dataBase
                        ),
                        filter: .favorites
                    ),
                    onItemSelected: { catId in
                        print(catId)
                    }
                )
                .tabItem {
                    Label("Favotites", systemImage: "star")
                }
            }
        }
    }
}
