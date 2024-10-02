import SwiftUI
import MapKit


struct RouteNavigationView: View {
    let source: MKMapItem
    let destination: MKMapItem
    @State private var position: MapCameraPosition = .automatic
    @State private var route: MKRoute?
    @State private var coordinates: [CLLocationCoordinate2D] = []
    @State private var startCoordinate: CLLocationCoordinate2D?
    
    var body: some View {
        Map(position: $position) {
            if let startCoordinate {
                Annotation("", coordinate: startCoordinate) {
                    Image(systemName: "location.north.fill")
                        .foregroundStyle(.blue)
                        .padding()
                }
                MapCircle(center: startCoordinate, radius: 5)
                    .foregroundStyle(.white.opacity(0.7))
            }
            
            ForEach(Array(coordinates.dropFirst().enumerated()), id: \.offset) { offset, coordinate in
                Annotation("", coordinate: coordinate, anchor: .bottom) {
                    Image(systemName: "bubble.middle.bottom.fill")
                        .font(.largeTitle)
                        .overlay {
                            Text("\(offset + 1)").foregroundStyle(.black).offset(y: -3)
                        }
                }
            }
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .mapStyle(.standard(elevation: .flat))
        .onAppear {
            getDirections()
        }
        .preferredColorScheme(.dark)
    }
    
    private func calculateAngle(from start: CLLocationCoordinate2D, to next: CLLocationCoordinate2D) -> Double {
        let deltaLongitude = next.longitude - start.longitude
        let deltaLatitude = next.latitude - start.latitude
        let angle = atan2(deltaLongitude, deltaLatitude) * (180 / .pi)
        let result = angle >= 0 ? angle : angle + 360
        return result
    }
    
    private func getDirections() {
        let request = MKDirections.Request()
        request.source = source
        request.destination = destination
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            guard let route = response?.routes.first else { return }
            self.route = route
            coordinates = route.steps.map { $0.polyline.coordinate }
            if coordinates.count < 2 { return }
            startCoordinate = coordinates[0]
            withAnimation {
                position = .camera(
                    MapCamera(
                        centerCoordinate: coordinates[0],
                        distance: 300,
                        heading: calculateAngle(from: coordinates[0], to: coordinates[1]),
                        pitch: 40
                    )
                )
            }
        }
    }
}

#Preview {
    RouteNavigationView(
        source: MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 35.172054987155555,
                    longitude: 136.88456594373685
                )
            )
        ),
        destination: MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 35.165644999461755,
                    longitude: 136.90506350950815
                )
            )
        )
    )
}
