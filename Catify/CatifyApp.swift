import SwiftUI
import SwiftData
import CatifyAPI
import CatifyUI

@main
struct CatifyApp: App {
    
    private let core = AppCore()
    @State private var path = [String]()
    
    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
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
                            path.append(catId)
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
                            path.append(catId)
                        }
                    )
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                }
                .navigationTitle("Catify")
                .navigationDestination(for: String.self) { catId in
                    CatDetailView(
                        viewModel: CatDetailViewModel(
                            repository: CatsRepository(
                                clientAPI: core.apiClient,
                                dataBase: core.dataBase
                            ),
                            catId: catId
                        )
                    )
                }
            }
        }
    }
}
