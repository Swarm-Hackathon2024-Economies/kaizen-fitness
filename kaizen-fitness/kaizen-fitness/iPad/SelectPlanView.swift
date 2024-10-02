import SwiftUI


let fitnessPlans: [FitnessPlan] = [
    .init(
        title: "Shoulder Shrug and Roll",
        type: .stretch,
        duration: .init(min: 15, max: 30),
        effectiveBodyParts: [.neck, .shoulder],
        musicTitle: "Workout"
    ),
    .init(
        title: "Seated Twist Stretch",
        type: .stretch,
        duration: .init(min: 20, max: 35),
        effectiveBodyParts: [.arm, .shoulder],
        musicTitle: "Relaxing"
    ),
    .init(
        title: "Steering Wheel Push",
        type: .relax,
        duration: .init(min: 10, max: 15),
        effectiveBodyParts: [.arm, .shoulder],
        musicTitle: "Chil"
    ),
    .init(
        title: "Seated Neck Roll",
        type: .relax,
        duration: .init(min: 30, max: 40),
        effectiveBodyParts: [.neck, .face],
        musicTitle: "Friday"
    ),
    .init(
        title: "Shoulder Shrug and Roll",
        type: .stretch,
        duration: .init(min: 15, max: 30),
        effectiveBodyParts: [.neck, .shoulder],
        musicTitle: "Workout"
    ),
    .init(
        title: "Seated Twist Stretch",
        type: .stretch,
        duration: .init(min: 20, max: 35),
        effectiveBodyParts: [.arm, .shoulder],
        musicTitle: "Relaxing"
    ),
    .init(
        title: "Steering Wheel Push",
        type: .relax,
        duration: .init(min: 10, max: 15),
        effectiveBodyParts: [.arm, .shoulder],
        musicTitle: "Chil"
    ),
    .init(
        title: "Seated Neck Roll",
        type: .relax,
        duration: .init(min: 30, max: 40),
        effectiveBodyParts: [.neck, .face],
        musicTitle: "Friday"
    ),
]

struct SelectPlanView: View {
    @Binding var path: AppNavigationPath
    @State private var tabSelection: ToyotaNaviSidebar.Item = .map
    @State private var selectedPlan: FitnessPlan? = nil
    
    var body: some View {
        HStack(spacing: 0) {
            ScrollView {
                VStack {
                    ForEach(fitnessPlans) { plan in
                        planCard(of: plan)
                    }
                }
                .padding()
            }
            if let selectedPlan {
                planDetail(of: selectedPlan)
                    .padding()
            } else {
                Rectangle().fill(.gray)
            }
        }
        .background(.gray)
        .toyotaNaviSidebar(selection: $tabSelection)
    }
    
    func planCard(of plan: FitnessPlan) -> some View {
        Button {
            selectedPlan = plan
        } label: {
            HStack(spacing: 24) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray)
                    .frame(width: 100, height: 100)
                VStack {
                    Text(plan.title)
                        .font(.title.bold())
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    HStack {
                        Spacer()
                        Text(plan.type.rawValue)
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(RoundedRectangle(cornerRadius: 8).fill(plan.type == .stretch ? .green : .pink))
                    }
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 16).fill(.white))
        }
    }
    
    func  planDetail(of plan: FitnessPlan) -> some View {
        VStack {
            Image("FitnessThumbnail")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(spacing: 16) {
                Text(plan.title).font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                HStack {
                    VStack {
                        Image(systemName: "stopwatch").font(.title.bold())
                        Text("\(plan.duration.min)~\(plan.duration.max)sec")
                            .font(.title3.bold())
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    VStack {
                        Image(systemName: "figure.strengthtraining.functional").font(.title.bold())
                        Text(plan.effectiveBodyParts.map { $0.rawValue }.joined(separator: " ,"))
                            .font(.title3.bold())
                            .frame(maxWidth: .infinity)
                    }
                    VStack {
                        Image(systemName: "music.note").font(.title.bold())
                        Text(plan.musicTitle)
                            .font(.title3.bold())
                            .frame(maxWidth: .infinity)
                    }
                }
                Spacer()
                Button {
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        path.append(.drive(fitnessPlan: plan))
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
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    SelectPlanView(path: .constant(AppNavigationPath()))
}
