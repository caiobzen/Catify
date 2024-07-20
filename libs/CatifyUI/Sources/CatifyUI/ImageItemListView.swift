import SwiftUI

public struct ImageItemListView: View {
    
    public var didToggleFavorite: ((String) -> ())? = nil
    public var didShowLastItem: (() -> ())? = nil
    
    private enum Constants {
        static let spacing: CGFloat = 20
    }
    
    private let imageItems: [ImageItem]
    private let showDetailText: Bool
    
    public init(imageItems: [ImageItem],
                didShowLastItem: (() -> ())? = nil,
                showDetailText: Bool = false,
                didToggleFavorite: ((String) -> ())? = nil) {
        self.imageItems = imageItems
        self.didShowLastItem = didShowLastItem
        self.showDetailText = showDetailText
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
                        ImageItemView(item: item, showDetailText: showDetailText)
                            .overlay {
                                FavoriteIconOverlay(isFavorite: item.isFavorite) {
                                    didToggleFavorite?(item.id)
                                }
                            }
                            .onAppear {
                                if item.id == imageItems.last?.id {
                                    didShowLastItem?()
                                }
                            }
                    }
                }
            }
            .padding()
        }
    }
}
