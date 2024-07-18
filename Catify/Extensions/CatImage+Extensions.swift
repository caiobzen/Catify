import CatifyAPI
import CatifyUI
import Foundation

extension CatImage: ImageItem {
    public var imageURL: URL { self.url }
    public var text: String { self.breeds.first?.name ?? "cat" }
}
