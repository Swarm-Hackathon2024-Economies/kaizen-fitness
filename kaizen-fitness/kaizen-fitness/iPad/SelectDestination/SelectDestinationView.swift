import SwiftUI
import MapKit


struct SelectDestinationView: View {
    @Binding var path: AppNavigationPath
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Map(position: $position, selection: $selectedResult) {
                UserAnnotation()
                ForEach(searchResults, id: \.self) { result in
                    Marker(item: result)
                }
                .annotationTitles(.hidden)
                
                if let route {
                    MapPolyline(route)
                        .stroke(.blue, lineWidth: 5)
                }
            }
//            .preferredColorScheme(.dark)
            .mapStyle(.standard(elevation: .realistic))
            .onChange(of: searchResults) {
                withAnimation {
                    position = .automatic
                }
            }
            .onChange(of: selectedResult) {
                getDirections()
            }
            .onChange(of: locationManager.coordinate) { oldValue, newValue in
                if oldValue != nil { return }
                guard let center = newValue else { return }
                position = .region(.init(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000))
            }
            .onMapCameraChange { context in
                visibleRegion = context.region
            }
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            
            GeometryReader { geometry in
                HStack {
                    MapFloatingSideBar(
                        searchResults: $searchResults,
                        currentLocationCoordinate: locationManager.coordinate,
                        visibleRegion: visibleRegion,
                        selectedResult: $selectedResult
                    )
                    .frame(maxWidth: geometry.size.width / 3)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(.leading)
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        if let selectedResult {
                            DestinationSetButton(path: $path, selectedResult: selectedResult, route: route)
                                .padding()
                                .frame(width: geometry.size.width / 3, height: 100)
                        }
                    }
                }
            }
        }
        .toyotaNaviSidebar(selection: .constant(.map))
        .onAppear {
            locationManager.requestLocation()
        }
//        .preferredColorScheme(.light)
    }
    
    func getDirections() {
        route = nil
        guard let selectedResult, let currentLocationCoordinate = locationManager.coordinate else { return }
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocationCoordinate))
        request.destination = selectedResult
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    }
}


#Preview {
    SelectDestinationView(path: .constant(AppNavigationPath()))
}
