import SwiftUI
import MapKit

struct DestinationSetButton: View {
    @Binding var path: AppNavigationPath
    let selectedResult: MKMapItem
    let route: MKRoute?
    
    private var travelTime: String? {
        guard let route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .short
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }
    
    var body: some View {
        Button {
            let plan = FitnessPlan(
                destinationName: selectedResult.name ?? "",
                destinationLatitude: selectedResult.placemark.coordinate.latitude,
                destinationLongitude: selectedResult.placemark.coordinate.longitude,
                activities: []
            )
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                path.append(.selectActivity(fitnessPlan: plan))
            }
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
    }
}
