import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            IOSHomeScreen()
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            iPadHomeScreen()
        }
    }
}

#Preview {
    ContentView()
}
