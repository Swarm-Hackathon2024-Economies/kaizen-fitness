import SwiftUI
import MapKit

struct ItemInfoView: View {
    let selectedResult: MKMapItem
    let route: MKRoute?
    @State private var lookAroundScene: MKLookAroundScene?
    
    private var travelTime: String? {
        guard let route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }
    
    func getLookAroundScene() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(mapItem: selectedResult)
            lookAroundScene = try? await request.scene
        }
    }
    
    var body: some View {
        Button {
            
        } label: {
            RoundedRectangle(cornerRadius: 18)
                .fill(.green)
                .overlay {
                    if let travelTime {
                        HStack {
                            Image(systemName: "car")
                            Text("出発")
                            Text(travelTime)
                        }
                        .foregroundStyle(.white)
                    } else {
                        ProgressView()
                    }
                }
        }
        .onAppear {
            getLookAroundScene()
        }
        .onChange(of: selectedResult) {
            getLookAroundScene()
        }
    }
}
