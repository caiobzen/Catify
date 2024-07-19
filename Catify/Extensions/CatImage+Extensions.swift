import CatifyUI
import CatifyDB
import Foundation

extension Cat: ImageItem {
    public var text: String { self.breedName }
    public var imageURL: URL { self.image }
}
