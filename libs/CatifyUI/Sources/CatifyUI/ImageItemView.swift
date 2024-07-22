import SwiftUI

struct ImageItemView: View {
    
    private enum Constants {
        static let imageSize: CGSize = .init(width: 100, height: 100)
        static let cornerRadius: CGFloat = 10
    }
    
    let item: ImageItem
    let showDetailText: Bool

    var body: some View {
        VStack {
            RemoteImage(url: item.imageURL)
                .scaledToFill()
                .frame(
                    width: Constants.imageSize.width,
                    height: Constants.imageSize.height
                )
                .clipped()
                .cornerRadius(Constants.cornerRadius)
            
            Text(item.text)
                .frame(maxWidth: .infinity)
            
            if showDetailText {
                Text(item.detailText)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
