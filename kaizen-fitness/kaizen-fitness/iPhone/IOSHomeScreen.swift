import SwiftUI

struct IOSHomeScreen: View {
    @ObservedObject var mcSessionManager = MCSessionManager()
    
    var body: some View {
        VStack {
            Text("iOS Home")
            
            Button {
                sendFitnessPlan()
            } label: {
                Text("ナディアパーク")
            }
        }
        .onAppear {
            mcSessionManager.start()
        }
        .onDisappear {
            mcSessionManager.invalidate()
        }
    }
    
    private func sendFitnessPlan() {
        let fitnessPlan = FitnessPlan.toNadyaPark
        guard let data = try? JSONEncoder().encode(fitnessPlan) else { return }
        mcSessionManager.sendDataToAllPeers(data: data)
    }
}

#Preview {
    IOSHomeScreen()
}
