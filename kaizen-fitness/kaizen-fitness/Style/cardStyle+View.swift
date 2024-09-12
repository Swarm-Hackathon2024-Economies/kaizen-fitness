import Foundation
import SwiftUI

extension View {
    func cardStyle() -> some View {
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding(EdgeInsets(top: 20, leading: 24, bottom: 56, trailing: 24))
    }
}
