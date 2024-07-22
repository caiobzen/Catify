import SwiftUI

struct FavoriteIconOverlay: View {
    
    private enum Constants {
        enum Assets {
            static let star = "star"
            static let starFill = "star.fill"
        }
        enum Icon {
            static let frame = CGSize(width: 16, height: 16)
            static let padding: CGFloat = 6
            static let backgroundOpacity: CGFloat = 0.7
        }
    }
    
    let isFavorite: Bool
    public var didToggleFavotite: (() -> ())? = nil
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    didToggleFavotite?()
                }) {
                    Image(systemName: isFavorite ? Constants.Assets.starFill : Constants.Assets.star)
                        .resizable()
                        .frame(width: Constants.Icon.frame.width, height: Constants.Icon.frame.height)
                        .padding(Constants.Icon.padding)
                        .background(Color.white.opacity(Constants.Icon.backgroundOpacity))
                        .clipShape(Circle())
                }
            }
            .padding(4)
            Spacer()
        }
    }
}

#Preview {
    FavoriteIconOverlay(isFavorite: true) { }
}
