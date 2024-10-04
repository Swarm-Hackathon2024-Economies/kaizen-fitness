import SwiftUI
import Combine

enum AppPath: Hashable {
    case selectPlan
    case drive(fitnessPlan: FitnessPlan)
}

typealias AppNavigationPath = [AppPath]

struct iPadHomeScreen: View {
    @State private var path = AppNavigationPath()
    @ObservedObject var mcSessionManager = MCSessionManager()
    
    var body: some View {
        NavigationStack(path: $path) {
            SelectActivityView(path: $path)
                .navigationDestination(for: AppPath.self, destination: destination)
        }
        .onAppear {
            mcSessionManager.start()
        }
        .onDisappear {
            mcSessionManager.invalidate()
        }
        .onChange(of: mcSessionManager.receivedData) { _, newValue in
            guard let data = newValue else { return }
            guard let fitnessPlan = try? JSONDecoder().decode(FitnessPlan.self, from: data) else { return }
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                path.append(.drive(fitnessPlan: fitnessPlan))
            }
        }
    }
    
    @ViewBuilder
    func destination(appPath: AppPath) -> some View {
        switch appPath {
        case .selectPlan:
            SelectActivityView(path: $path)
        case .drive(let fitnessPlan):
            DriveView(fitnessPlan: fitnessPlan)
                .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    iPadHomeScreen()
}
