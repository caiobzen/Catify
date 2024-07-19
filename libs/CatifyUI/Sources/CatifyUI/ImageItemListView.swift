import SwiftUI

public struct ImageItemListView: View {
    
    public var didToggleFavorite: ((String) -> ())? = nil
    
    private enum Constants {
        static let spacing: CGFloat = 20
    }
    
    private let imageItems: [ImageItem]
    
    public init(imageItems: [ImageItem],
                didToggleFavorite: ((String) -> ())? = nil) {
        self.imageItems = imageItems
        self.didToggleFavorite = didToggleFavorite
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns,
                      spacing: Constants.spacing) {
                ForEach(imageItems, id: \.id) { item in
                    ZStack {
                        ImageItemView(item: item)
                            .overlay {
                                FavoriteIconOverlay(isFavorite: item.isFavorite) {
                                    didToggleFavorite?(item.id)
                                }
                            }
                    }
                }
            }
            .padding()
        }
    }
}
