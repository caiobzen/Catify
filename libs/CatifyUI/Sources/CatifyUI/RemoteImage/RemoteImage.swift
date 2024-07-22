import SwiftUI

public struct RemoteImage: View {
    var imageLoader: ImageLoader

    public init(url: URL) {
        imageLoader = ImageLoader(url: url)
    }

    public var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            ProgressView()
        }
    }
}
