import SwiftUI
import MapKit
import Charts


struct DriveView: View {
    @State private var sidebarSelection: ToyotaNaviSidebar.Item = .map
    @State private var activityIsInProgress: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                RouteNavigationView(
                    source: Place.daiNagoyaBuilding,
                    destination: Place.nadyaPark
                )
                
                if activityIsInProgress {
                    activityView(width: geometry.size.width / 2)
                } else {
                    nextActivityCards
                        .frame(width: geometry.size.width / 2)
                        .padding()
                }
            }
        }
        .toyotaNaviSidebar(selection: $sidebarSelection)
    }
    
    var nextActivityCards: some View {
        VStack {
            NextActivituCard(
                title: "1. Neck stretch activity",
                distance: 10,
                imageName: "NeckStretch",
                progress: 0.4
            )
            NextActivituCard(
                title: "2. Shoulder stretch",
                distance: 20,
                imageName: "FitnessThumbnail",
                progress: 0
            )
        }
    }
    
    func activityView(width: CGFloat) -> some View {
        Image("NeckStretch")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width)
            .offset(x: 250)
            .clipped()
            .overlay(alignment: .bottom) {
                HStack {
                    VStack(spacing: 24) {
                        Text("Neck Stretches")
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 16) {
                            HStack(spacing: 8) {
                                Image(systemName: "heart.fill")
                                    .foregroundStyle(.pink)
                                Text("30")
                                    .font(.title2.bold())
                                Text("point")
                            }
                            HStack(spacing: 8) {
                                Image(systemName: "clock")
                                    .foregroundStyle(.pink)
                                Text("25")
                                    .font(.title2.bold())
                                Text("seconds")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    ZStack {
                        Chart {
                            SectorMark(angle: .value("Red", 4))
                                .foregroundStyle(.gray)
                            SectorMark(angle: .value("Green", 6))
                                .foregroundStyle(.blue)
                        }
                        .frame(width: 100, height: 100)
                        
                        Text("8")
                            .font(.system(size: 70).bold())
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.5), radius: 5, y: 5)
                    }
                }
                .foregroundStyle(.black)
                .padding()
                .background(RoundedRectangle(cornerRadius: 24).fill(.white.opacity(0.7)))
                .padding()
            }
    }
}

#Preview {
    DriveView()
}
