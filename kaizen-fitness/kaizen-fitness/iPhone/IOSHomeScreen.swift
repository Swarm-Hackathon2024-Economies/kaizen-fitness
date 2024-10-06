import SwiftUI

struct IOSHomeScreen: View {
    @ObservedObject var mcSessionManager = MCSessionManager()
    
    var body: some View {
        VStack {
            Text("iOS Home")
            if let peer = mcSessionManager.connectedPeerID {
                Text(peer.displayName)
            }
            
            Button {
                sendFitnessPlan()
            } label: {
                Text("ミッドランドスクエアに行くプランを送信")
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
        let fitnessPlan = FitnessPlan.toMidlandSquare
        guard let data = try? JSONEncoder().encode(fitnessPlan) else { return }
        mcSessionManager.sendDataToAllPeers(data: data)
    }
}

#Preview {
    IOSHomeScreen()
}
