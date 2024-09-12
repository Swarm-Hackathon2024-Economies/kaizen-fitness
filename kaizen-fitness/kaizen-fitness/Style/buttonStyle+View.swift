import Foundation
import SwiftUI


extension View {
    func primaryButtonStyle() -> some View {
        return self
            .font(.headline)
            .frame(width: 313, height: 60, alignment: .center)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(30)
            .padding(.vertical, 26)
    }
    
    func secondaryButtonStyle() -> some View {
        return self
            .frame(width: 300, height: 60, alignment: .center)
            .cornerRadius(30)
            .overlay(
              RoundedRectangle(cornerRadius: 30)
                .inset(by: 0.5)
                .stroke(Color.blue, lineWidth: 1)
            )
    }
}
