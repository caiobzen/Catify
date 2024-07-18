import SwiftUI

public struct ImageItemListView: View {
    
    private enum Constants {
        static let spacing: CGFloat = 20
        static let imageSize: CGSize = .init(width: 100, height: 100)
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
                ForEach(imageItems, id: \.id) { item in
                    VStack {
                        AsyncImage(url: item.imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(
                            width: Constants.imageSize.width,
                            height: Constants.imageSize.height
                        )
                        
                        Text(item.text)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding()
        }
    }
}
