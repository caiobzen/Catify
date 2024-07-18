import Foundation

public struct ImageItem {
    let id: String
    let text: String
    let imageURL: URL
    
    public init(id: String, text: String, imageURL: URL) {
        self.id = id
        self.text = text
        self.imageURL = imageURL
    }
}
