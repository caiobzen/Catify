import CatifyUI
import CatifyDB
import Foundation

extension Cat: ImageItem {
    public var text: String { self.breedName ?? "cat breed" }
    public var imageURL: URL { self.image ?? URL(string: "http://cat.com")! }
}
