import Foundation

public protocol ImageItem {
    var id: String { get }
    var text: String { get }
    var detailText: String { get }
    var imageURL: URL { get }
    var isFavorite: Bool { get }
}
