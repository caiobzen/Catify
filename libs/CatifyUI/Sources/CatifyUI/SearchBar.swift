import SwiftUI

public struct SearchBar: View {
    
    private enum Constants {
        enum TextField {
            static let horizontalPadding: CGFloat = 35
            static let verticalPadding: CGFloat = 7
            static let cornerRadius: CGFloat = 8
        }
        enum Icon {
            static let trailingPadding: CGFloat = 8
        }
        enum Assets {
            static let magnifyingGlass = "magnifyingglass"
            static let multipleCircleFill = "multiply.circle.fill"
        }
        static let generalPadding: CGFloat = 10
    }
    
    @Binding private var queryString: String
    
    public init(queryString: Binding<String>) {
        self._queryString = queryString
    }
    
    public var body: some View {
        HStack {
            TextField("Search...", text: $queryString)
                .padding(.vertical, Constants.TextField.verticalPadding)
                .padding(.horizontal, Constants.TextField.horizontalPadding)
                .background(Color(.systemGray6))
                .cornerRadius(Constants.TextField.cornerRadius)
                .overlay(
                    HStack {
                        Image(systemName: Constants.Assets.magnifyingGlass)
                            .foregroundColor(.gray)
                            .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !queryString.isEmpty {
                            Button(action: {
                                self.queryString = ""
                            }) {
                                Image(systemName: Constants.Assets.multipleCircleFill)
                                    .foregroundColor(.gray)
                                    .padding(.trailing, Constants.Icon.trailingPadding)
                            }
                        }
                    }
                )
                .padding(.horizontal, Constants.generalPadding)
        }
        .padding(.top, Constants.generalPadding)
    }
}
