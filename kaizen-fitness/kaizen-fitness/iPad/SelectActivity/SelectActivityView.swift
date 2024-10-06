import SwiftUI


struct SelectActivityView: View {
    @Binding var path: AppNavigationPath
    let fitnessPlan: FitnessPlan
    @State private var tabSelection: ToyotaNaviSidebar.Item = .map
    @State private var selectedActivity: Activity? = nil
    let activities: [Activity] = [
        .stretchesToRelieveShoulderAndNeckTension,
        .shoulderShrugAndRoll,
        .breathMethod,
        .steeringWheelPush,
        .seatedNeckRoll,
        .shout,
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollView {
                VStack {
                    ForEach(activities, id: \.title) { activity in
                        activityCard(of: activity)
                    }
                }
                .padding()
            }
            if let selectedActivity {
                planDetail(of: selectedActivity)
                    .padding()
            } else {
                Rectangle().fill(.gray)
            }
        }
        .background(.gray)
        .toyotaNaviSidebar(selection: $tabSelection)
    }
    
    func activityCard(of activity: Activity) -> some View {
        Button {
            selectedActivity = activity
        } label: {
            HStack(spacing: 24) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray)
                    .frame(width: 100, height: 100)
                VStack {
                    Text(activity.title)
                        .font(.title.bold())
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    HStack {
                        Spacer()
                        Text(activity.type.rawValue)
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 8).fill(activity.type == .stretch ? .green : .pink))
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).fill(.white))
        }
    }
    
    func  planDetail(of activity: Activity) -> some View {
        VStack {
            Image("FitnessThumbnail")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(spacing: 16) {
                Text(activity.title).font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                HStack {
                    VStack {
                        Image(systemName: "stopwatch").font(.title.bold())
                        Text("\(activity.duration.min)~\(activity.duration.max)sec")
                            .font(.title3.bold())
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    VStack {
                        Image(systemName: "figure.strengthtraining.functional").font(.title.bold())
                        Text(activity.effectiveBodyParts.map { $0.rawValue }.joined(separator: " ,"))
                            .font(.title3.bold())
                            .frame(maxWidth: .infinity)
                    }
                    VStack {
                        Image(systemName: "music.note").font(.title.bold())
                        Text(activity.musicTitle)
                            .font(.title3.bold())
                            .frame(maxWidth: .infinity)
                    }
                }
                Spacer()
                Button {
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        let newPlan = FitnessPlan(
                            destinationName: fitnessPlan.destinationName,
                            destinationLatitude: fitnessPlan.destinationLatitude,
                            destinationLongitude: fitnessPlan.destinationLongitude,
                            activities: [selectedActivity!, .seatedNeckRoll, .shoulderShrugAndRoll]
                        )
                        path.append(.drive(fitnessPlan: newPlan))
                    }
                } label: {
                    Text("Set")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).fill(.blue))
                }
            }
            .padding()
        }
        .foregroundStyle(.black)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    SelectActivityView(path: .constant(AppNavigationPath()), fitnessPlan: .toDaiNagoyaBuilding)
}
