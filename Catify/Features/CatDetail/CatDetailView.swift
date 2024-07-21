import SwiftUI
import CatifyDB
import CatifyAPI

struct CatDetailView: View {

    private var viewModel: CatDetailViewModel
    
    init(viewModel: CatDetailViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
            List {
                Section {
                    AsyncImage(url: viewModel.cat.imageURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .border(.gray, width: 1)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding()
                }
                
                ForEach(viewModel.catInfoSections, id: \.header) { section in
                    Section {
                        Text(section.text)
                    } header: {
                        Text(section.header)
                    }
                }
            }
            .toolbar {
                Button {
                    viewModel.toggleFavorite()
                } label: {
                    Image(systemName: viewModel.cat.isFavorite
                          ? "star.fill"
                          : "star")
                }
            }
        .navigationTitle(viewModel.cat.breedName ?? "")
    }
}

// MARK: - Preview
#Preview {
    struct CatifyDataBaseStub: CatifyDataBaseProtocol {
        func fetchCats(favoritesOnly: Bool) -> [CatifyDB.Cat] { [] }
        func insert(cat: CatifyDB.Cat) { }
        func deleteAllCats() { }
        func toggleFavorite(catId: String) { }
        func fetchCatWith(id: String) -> CatifyDB.Cat? {
            Cat(id: "1",
                image: URL(string: "https://cdn2.thecatapi.com/images/xBR2jSIG7.jpg"),
                breedName: "Turkish Angora",
                origin: "Turkey",
                temperament: "Affectionate, Agile, Clever, Gentle, Intelligent, Playful, Social",
                lifespan: "15 - 18",
                desc: "This is a smart and intelligent cat which bonds well with humans. With its affectionate and playful personality the Angora is a top choice for families. The Angora gets along great with other pets in the home, but it will make clear who is in charge, and who the house belongs to")
        }
    }
    
    return NavigationStack {
        CatDetailView(
            viewModel: CatDetailViewModel(
                repository: .init(
                    clientAPI: CatifyAPIClient(apiKey: ""),
                    dataBase: CatifyDataBaseStub()
                ),
                catId: "1"
            )
        )
    }
}
