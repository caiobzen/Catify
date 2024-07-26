import SwiftUI
import SwiftData
import CatifyAPI
import CatifyUI

@main
struct CatifyApp: App {
    
    private enum Constants {
        static let appName = "Catify"
        enum Tab {
            static let cats = ("Cats", "cat")
            static let favorites = ("Favorites", "star")
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
                        Label(Constants.Tab.cats.0, systemImage: Constants.Tab.cats.1)
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
                        Label(Constants.Tab.favorites.0, systemImage: Constants.Tab.favorites.1)
                    }
                }
                .navigationTitle(Constants.appName)
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
            .onAppear {
                setupForUITestingIfNeeded()
            }
        }
    }
    
    // MARK: - UITesting setup
    private func setupForUITestingIfNeeded() {
        if ProcessInfo.processInfo.arguments.contains("UITesting") {
            UserDefaults.standard.setValue(0, forKey: "page")
            core.dataBase.deleteAllCats()
        }
    }
}

