import SwiftUI

struct ImageItemView: View {
    
    private enum Constants {
        static let imageSize: CGSize = .init(
            width: (UIScreen.main.bounds.width / 3) - 16,
            height: 100
        )
        static let cornerRadius: CGFloat = 10
        static let textMinHeight: CGFloat = 32
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
                .frame(
                    maxWidth: .infinity,
                    minHeight: Constants.textMinHeight
                )
            
            if showDetailText {
                HStack {
                    Text(item.detailText)
                        .font(.footnote)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
    }
}
