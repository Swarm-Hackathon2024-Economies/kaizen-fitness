import SwiftUI

struct DriveScoreView: View {
    var accelerationScore: Int
    var brakeScore: Int

    init(accelerationScore: Int, brakeScore: Int) {
        self.accelerationScore = accelerationScore
        self.brakeScore = brakeScore
    }

    var body: some View {
        VStack(spacing: 20) {
            ScoreCard(title: "Acceleration Score", score: accelerationScore, color: scoreColor(for: accelerationScore))
            ScoreCard(title: "Brake Score", score: brakeScore, color: scoreColor(for: brakeScore))
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 8)
        .padding()
    }

    // スコアに基づいて色を決定する関数
    func scoreColor(for score: Int) -> Color {
        switch score {
        case 0..<25:
            return .red
        case 25..<50:
            return .yellow
        case 50..<75:
            return .blue
        case 75...100:
            return .green
        default:
            return .gray // スコアが範囲外の場合のデフォルト
        }
    }
}

struct ScoreCard: View {
    var title: String
    var score: Int
    var color: Color

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            HStack {
                Text("\(score)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(color)
                Spacer()
                ProgressView(value: Double(score), total: 100)
                    .accentColor(color)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

#Preview {
    DriveScoreView(accelerationScore: 40, brakeScore: 50)
}
