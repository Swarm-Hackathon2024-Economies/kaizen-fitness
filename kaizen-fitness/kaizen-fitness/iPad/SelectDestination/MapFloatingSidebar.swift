import SwiftUI
import MapKit

struct MapFloatingSideBar: View {
    @Binding var searchResults: [MKMapItem]
    var currentLocationCoordinate: CLLocationCoordinate2D?
    var visibleRegion: MKCoordinateRegion?
    @Binding var selectedResult: MKMapItem?
    @State private var searchText: String = ""
    @FocusState var focused: Bool
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText)
                        .focused($focused)
                        .submitLabel(.search)
                        .onSubmit {
                            search(for: searchText)
                        }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.quaternary)
                )
                if focused {
                    Button("キャンセル") {
                        focused = false
                        searchText = ""
                    }
                    .foregroundStyle(.blue)
                    .transition(.slide)
                }
            }
            .animation(.easeInOut, value: focused)
            .padding()
            
            List {
                ForEach(searchResults, id: \.self) { result in
                    Button {
                        selectedResult = result
                    } label: {
                        Text("\(result.name ?? "")")
                    }
                    .foregroundStyle(.black)
                    .listRowBackground(selectedResult == result ? Color.blue : Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
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
