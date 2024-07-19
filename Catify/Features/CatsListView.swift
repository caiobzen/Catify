import Foundation
import SwiftUI
import CatifyAPI
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
            ImageItemListView(imageItems: viewModel.imageItems)
        }
        .onAppear {
            Task { await viewModel.fetchData() }
        }
    }
}

#Preview {
    CatsListView(
        viewModel: CatsListViewModel(
            clientAPI: CatifyAPIClient(apiKey: "")
        )
    )
}
