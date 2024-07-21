import SwiftUI
import CatifyDB

struct CatDetailView: View {
    private var viewModel: CatDetailViewModel
    
    init(viewModel: CatDetailViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        Text(viewModel.cat.breedName ?? "Unknown")
    }
}
