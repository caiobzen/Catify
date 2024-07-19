import Foundation
import SwiftUI
import CatifyAPI
import CatifyDB
import CatifyUI

struct CatsListView: View {
    
    private var viewModel: CatsListViewModel
    
    init(viewModel: CatsListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            SearchBar(queryString: Binding(
                get: { viewModel.searchQuery } ,
                set: { viewModel.searchQuery = $0 })
            )
            ImageItemListView(imageItems: viewModel.imageItems) { id in
                viewModel.toggleFavorite(for: id)
            }
        }
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
