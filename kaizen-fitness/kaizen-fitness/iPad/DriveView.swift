import SwiftUI
import MapKit
import Charts


struct DriveView: View {
    let fitnessPlan: FitnessPlan
    @State private var sidebarSelection: ToyotaNaviSidebar.Item = .map
    @State private var activityIsInProgress: Bool = false
    
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
            ForEach(
                Array(fitnessPlan.activities.enumerated().filter { $0.offset < 2 }),
                id: \.offset
            ) { offset, activity in
                NextActivituCard(
                    title: "\(offset + 1). \(activity.title)",
                    distance: 10,
                    imageName: "NeckStretch",
                    progress: 0.4
                )
            }
        }
    }
    
    @State private var activityRemainingTime: Int = 10
    
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
                            SectorMark(angle: .value("", activityRemainingTime))
                                .foregroundStyle(.gray)
                            SectorMark(angle: .value("", 10 - activityRemainingTime))
                                .foregroundStyle(.blue)
                        }
                        .animation(.linear(duration: 1), value: activityRemainingTime)
                        .frame(width: 100, height: 100)
                        .onAppear {
                            activityRemainingTime -= 1
                            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                                if activityRemainingTime > 0 {
                                    activityRemainingTime -= 1
                                } else {
                                    var transaction = Transaction()
                                    transaction.disablesAnimations = true
                                    withTransaction(transaction) {
                                        activityRemainingTime = 10
                                    }
                                }
                            }
                        }
                        
                        Text("\(activityRemainingTime)")
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
    DriveView(fitnessPlan: .toNadyaPark)
}
