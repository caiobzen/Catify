import Foundation
import SwiftUI
import CatifyAPI
import CatifyDB
import CatifyUI

struct CatsListView: View {
    
    private var viewModel: CatsListViewModel
    var onItemSelected: ((String) -> ())? = nil
    
    init(viewModel: CatsListViewModel,
         onItemSelected: ((String) -> ())? = nil) {
        self.viewModel = viewModel
        self.onItemSelected = onItemSelected
    }
    
    var body: some View {
        VStack {
            SearchBar(queryString: Binding(
                get: { viewModel.searchQuery } ,
                set: { viewModel.searchQuery = $0 })
            )
            
            ZStack {
                ImageItemListView(
                    imageItems: viewModel.imageItems,
                    didShowLastItem: { fetchData() },
                    showDetailText: viewModel.filter == .favorites,
                    didToggleFavorite: { viewModel.toggleFavorite(for: $0) },
                    didTapItem: { onItemSelected?($0) }
                )
                .onAppear(perform: fetchData)
                
                if viewModel.isFetching {
                    VStack {
                        Spacer()
                        LoadingMoreView(text: "Fetching More Cats... ")
                    }
                }
            }
        }
    }
    
    private func fetchData() {
        Task { await viewModel.fetchData() }
    }
}

#Preview {
    CatsListView(
        viewModel: CatsListViewModel(
            repository: .init(
                clientAPI: CatifyAPIClient(apiKey: ""),
                dataBase: try! CatifyDataBase()
            )
        )
    )
}
