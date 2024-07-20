import Foundation
import SwiftUI
import CatifyAPI
import CatifyDB
import CatifyUI

struct CatsListView: View {
    
    private var viewModel: CatsListViewModel
    
    init(viewModel: CatsListViewModel,
         filterFavorites: Bool = false) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            SearchBar(queryString: Binding(
                get: { viewModel.searchQuery } ,
                set: { viewModel.searchQuery = $0 })
            )
            ImageItemListView(imageItems: viewModel.imageItems,
                              didToggleFavorite: { viewModel.toggleFavorite(for: $0) },
                              didShowLastItem: { fetchData() })
            .onAppear(perform: fetchData)
            if viewModel.isFetching {
                
                HStack {
                    Spacer()
                    Text("Loading More Cats ")
                    ProgressView()
                    Spacer()
                }
                .padding()
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
            clientAPI: CatifyAPIClient(apiKey: ""),
            dataBase: try! CatifyDataBase()
        )
    )
}
