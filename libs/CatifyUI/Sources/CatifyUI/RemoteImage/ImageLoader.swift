import UIKit

@Observable
class ImageLoader {

    var image: UIImage?
    private var url: URL

    init(url: URL) {
        self.url = url
        Task {
            await loadImage()
        }
    }

    @MainActor
    private func loadImage() async {
        if let cachedImage = ImageCache.shared.get(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        }

        let data = try? await URLSession.shared.data(for: URLRequest(url: url))
        if let data, let image = UIImage(data: data.0) {
            self.image = image
            ImageCache.shared.set(image, forKey: self.url.absoluteString)
        }
    }
}
