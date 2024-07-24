import SwiftUI
import SwiftData
import CatifyAPI
import CatifyUI

@main
struct CatifyApp: App {
    
    private enum Constants {
        enum Tab {
            static let cats = "Cats"
            static let favorites = "Favorites"
        }
        enum Asset {
            static let cat = "cat"
            static let star = "star"
        }
    }
    
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
                        Label(Constants.Tab.cats, systemImage: Constants.Asset.cat)
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
                        Label(Constants.Tab.favorites, systemImage: Constants.Asset.star)
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
            .tint(.primary)
        }
    }
}
