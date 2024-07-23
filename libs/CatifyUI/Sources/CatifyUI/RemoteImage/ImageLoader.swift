import UIKit

@Observable
class ImageLoader {
    
    private enum Constants {
        static let placeholderAssetName = "placeholder"
        static let placeholderType = "png"
    }

    var image: UIImage?
    private let cache: ImageCacheProtocol
    private let urlSession: URLSessionProtocol
    private var url: URL

    init(url: URL, 
         cache: ImageCacheProtocol = ImageCache.shared,
         urlSession: URLSessionProtocol = URLSession.shared) {
        self.url = url
        self.cache = cache
        self.urlSession = urlSession
        Task {
            await loadImage()
        }
    }

    @MainActor
    private func loadImage() async {
        if let cachedImage = cache.get(forKey: url.absoluteString) {
            self.image = cachedImage
            return
        } else {
            setPlaceholderImage(for: url)
        }

        let data = try? await urlSession.data(for: URLRequest(url: url))
        if let data, let image = UIImage(data: data.0) {
            self.image = image
            cache.set(image, forKey: self.url.absoluteString)
        }
    }
    
    @MainActor
    private func setPlaceholderImage(for url: URL) {
        if let path = Bundle.module.path(
            forResource: Constants.placeholderAssetName,
            ofType: Constants.placeholderType
        ), let image = UIImage(contentsOfFile: path) {
            self.image = image
            cache.set(image, forKey: url.absoluteString)
        }
    }
}
