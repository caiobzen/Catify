import UIKit

class ImageCache {

    static let shared = ImageCache()
    
    var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        return cache
    }()

    private init() {}

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func get(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
}
