import SwiftUI

public struct LoadingMoreView: View {
    
    let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        HStack {
            Text(text)
            ProgressView()
                .tint(.white)
        }
        .foregroundStyle(Color.white)
        .padding()
        .background(Capsule().fill(Color.black))
        .padding()
    }
}

#Preview {
    LoadingMoreView(text: "Loading More Cats... ")
}
