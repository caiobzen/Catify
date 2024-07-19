import SwiftUI

public struct ImageItemListView: View {
    
    private enum Constants {
        static let spacing: CGFloat = 20
    }
    
    private let imageItems: [ImageItem]
    
    public init(imageItems: [ImageItem]) {
        self.imageItems = imageItems
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
                ForEach(imageItems, id: \.id) {
                    ImageItemView(item: $0)
                }
            }
            .padding()
        }
    }
}
