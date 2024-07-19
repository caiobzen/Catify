import SwiftUI

struct ImageItemView: View {
    
    private enum Constants {
        static let imageSize: CGSize = .init(width: 100, height: 100)
    }
    
    let item: ImageItem

    var body: some View {
        VStack {
            AsyncImage(url: item.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: Constants.imageSize.width,
                        height: Constants.imageSize.height
                    )
                    .clipped()
                    .border(.gray, width: 1)
                    .cornerRadius(10)
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
