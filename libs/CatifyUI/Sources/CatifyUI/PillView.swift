import SwiftUI

public struct PillView: View {
    
    let text: String
    let showProgress: Bool
    let icon: String?
    var onTap: (() -> ())?
    
    public init(text: String,
                showProgress: Bool = false,
                icon: String? = nil,
                onTap: (() -> ())? = nil) {
        self.text = text
        self.showProgress = showProgress
        self.icon = icon
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: {
            onTap?()
        }, label: {
            HStack {
                Text(text)
                if showProgress {
                    ProgressView()
                }
                if let icon {
                    Image(systemName: icon)
                }
            }
            .tint(.white)
            .foregroundStyle(Color.white)
            .padding()
            .background(Capsule().fill(Color.black))
            .padding()
        })
    }
}

#Preview {
    PillView(text: "Loading More... ")
}
