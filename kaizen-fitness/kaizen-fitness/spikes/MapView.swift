import SwiftUI
import MapKit


struct MapView: View {
    @State private var position: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedResult: MKMapItem?
    @State private var route: MKRoute?
    @ObservedObject private var locationManager = LocationManager()
    @State private var showSheet: Bool = true
    
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
            .mapStyle(.standard(elevation: .realistic))
            .onChange(of: searchResults) {
                position = .automatic
            }
            .onChange(of: selectedResult) {
                getDirections()
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
                    SideBar(
                        searchResults: $searchResults,
                        currentLocationCoordinate: locationManager.coordinate,
                        visibleRegion: visibleRegion,
                        selectedResult: $selectedResult
                    )
                    .frame(maxWidth: geometry.size.width / 3)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding(.leading)
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        if let selectedResult {
                            ItemInfoView(selectedResult: selectedResult, route: route)
                                .padding()
                                .frame(width: geometry.size.width / 3, height: 100)
                        }
                    }
                }
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
        .preferredColorScheme(.dark)
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

struct SideBar: View {
    @Binding var searchResults: [MKMapItem]
    var currentLocationCoordinate: CLLocationCoordinate2D?
    var visibleRegion: MKCoordinateRegion?
    @Binding var selectedResult: MKMapItem?
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { result in
                    Button {
                        selectedResult = result
                    } label: {
                        Text("\(result.name ?? "")")
                    }
                    .foregroundStyle(.white)
                    .listRowBackground(selectedResult == result ? Color.blue : Color.black)
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .onSubmit(of: .search) {
            search(for: searchText)
        }
    }
    
    func search(for query: String) {
        guard let currentLocationCoordinate else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = visibleRegion ?? MKCoordinateRegion(
            center: currentLocationCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            withAnimation {
                searchResults = response?.mapItems ?? []
            }
        }
    }
}


#Preview {
    MapView()
}
