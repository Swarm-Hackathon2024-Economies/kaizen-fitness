import SwiftUI

struct NextActivituCard: View {
    let title: String
    let distance: Int
    let imageName: String
    let progress: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(.white.opacity(0.5))
            .frame(height: 200)
            .overlay {
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.blue.opacity(0.5))
                        .frame(width: geometry.size.width * progress)
                }
            }
            .overlay {
                HStack(alignment: .top) {
                    VStack(spacing: 0) {
                        Text(title)
                            .font(.title.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(spacing: 30) {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 60).bold())
                            HStack(alignment: .bottom, spacing: 0) {
                                Text(distance.description)
                                    .font(.system(size: 60).bold())
                                Text("mile")
                                    .font(.title2.bold())
                                    .offset(y: -13)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                    }
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                }
                .foregroundStyle(.white)
                .padding()
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NextActivituCard(
        title: "1. Neck stretch activity",
        distance: 10,
        imageName: "FitnessThumbnail",
        progress: 0.4
    )
}
