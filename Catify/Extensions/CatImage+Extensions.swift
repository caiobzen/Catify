import CatifyUI
import CatifyDB
import Foundation

extension Cat: ImageItem {
    
    private enum Constants {
        static let unknown = "Unknown"
        static let fallbackImageURL = "https://placehold.co/600x400/png"
    }
    
    public var text: String { self.breedName ?? Constants.unknown }
    public var detailText: String {
        "Avg. Lifespan:\n\(self.averageLifespan)"
    }
    public var imageURL: URL { self.image ?? URL(string: Constants.fallbackImageURL)! }
}

private extension Cat {
    var averageLifespan: String {
        guard let components = lifespan?.split(separator: "-"),
              components.count == 2,
              let start = Int(components[0].trimmingCharacters(in: .whitespaces)),
              let end = Int(components[1].trimmingCharacters(in: .whitespaces)) else {
            return Constants.unknown
        }
        let average = (start + end) / 2
        return "\(average) years"
    }
}
