import SwiftUI

enum AppPath: Hashable {
    case selectPlan
    case drive(fitnessPlan: FitnessPlan)
}

typealias AppNavigationPath = [AppPath]

struct iPadHomeScreen: View {
    @State private var path = AppNavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            SelectPlanView(path: $path)
                .navigationDestination(for: AppPath.self, destination: destination)
        }
    }
    
    @ViewBuilder
    func destination(appPath: AppPath) -> some View {
        switch appPath {
        case .selectPlan:
            SelectPlanView(path: $path)
        case .drive(let fitnessPlan):
            DriveView(fitnessPlan: fitnessPlan)
                .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    iPadHomeScreen()
}
