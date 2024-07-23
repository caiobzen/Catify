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
        
        Task { await viewModel.fetchData() }
    }
    
    var body: some View {
        
        ZStack {
            if viewModel.imageItems.isEmpty {
                ContentUnavailableView("There are no cats to list", systemImage: "cat")
            } else {
                VStack {
                    SearchBar(queryString: Binding(
                        get: { viewModel.searchQuery } ,
                        set: { viewModel.searchQuery = $0 })
                    )
                    
                    ZStack {
                        ImageItemListView(
                            imageItems: viewModel.imageItems,
                            didShowLastItem: { fetchData() },
                            showDetailText: viewModel.isFilteringByFavorites,
                            didToggleFavorite: { viewModel.toggleFavorite(for: $0) },
                            didTapItem: { onItemSelected?($0) }
                        )
                    }
                }
            }
            if viewModel.isFetching {
                VStack {
                    Spacer()
                    PillView(text: "Loading... ", showProgress: true)
                }
            }
            else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Spacer()
                    PillView(text: "\(errorMessage) | Tap to retry") {
                        fetchData()
                    }
                }
                
            }
        }
        .onAppear {
            if viewModel.isFilteringByFavorites {
                fetchData()
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
