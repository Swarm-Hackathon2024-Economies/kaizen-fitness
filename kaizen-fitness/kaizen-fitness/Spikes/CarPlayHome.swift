import SwiftUI

struct CarPlayHome: View {
    @State private var selectedApp: String? = nil
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Sidebar(width: geometry.size.width / 8, selectedApp: $selectedApp)
                AppGrid(selectedApp: $selectedApp)
            }
        }
        .background(wallpaper)
        .preferredColorScheme(.dark)
    }
    
    private var wallpaper: some View {
        Image("Wallpaper")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}

struct AppGrid: View {
    @Binding var selectedApp: String?
    
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Grid(horizontalSpacing: 40, verticalSpacing: 40) {
                    GridRow {
                        app("books")
                        app("calendar")
                        app("maps")
                        app("messages")
                    }
                    GridRow {
                        app("music")
                        app("setting")
                        app("phone")
                        app("podcast")
                    }
                }
                .padding(40)
                
                PageIndicator()
            }
            if let app = selectedApp {
                Rectangle()
                    .overlay {
                        Text(app).foregroundStyle(.black).font(.largeTitle)
                    }
                    .ignoresSafeArea()
            }
        }
    }
    
    func app(_ name: String) -> some View {
        Button {
            withAnimation(.linear(duration: 0.2)) {
                selectedApp = name
            }
        } label: {
            VStack {
                AppIcon(of: name)
                Text(name)
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.thinMaterial))
            }
        }
    }
}

struct PageIndicator: View {
    var body: some View {
        HStack(spacing: 40) {
            Circle().fill(.secondary).frame(width: 24)
            Circle().fill(.white).frame(width: 24)
            Circle().fill(.secondary).frame(width: 24)
        }
    }
}

struct Sidebar: View {
    let width: CGFloat
    @Binding var selectedApp: String?
    
    var body: some View {
        VStack {
            Text(timeNow()).font(.title.bold())
            HStack {
                Image(systemName: "cellularbars")
                Text("5G")
            }
            .font(.title.bold())
            
            Spacer()
            app("maps")
            app("music")
            app("messages")
            Spacer()
            
            Button {
                withAnimation {
                    selectedApp = nil
                }
            } label: {
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                    VStack {
                        RoundedRectangle(cornerRadius: 8)
                        RoundedRectangle(cornerRadius: 8)
                        RoundedRectangle(cornerRadius: 8)
                    }
                }
                .foregroundStyle(.white)
                .padding(8)
                .frame(maxHeight: 70)
            }
        }
        .padding(8)
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        )
        .frame(width: width)
    }
    
    private func app(_ name: String) -> some View {
        Button {
            withAnimation {
                selectedApp = name
            }
        } label: {
            AppIcon(of: name)
        }
    }
    
    private func timeNow() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        let now = Date()
        return formatter.string(from: now)
    }
}

struct AppIcon: View {
    let name: String
    
    init(of name: String) {
        self.name = name
    }
    
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}

#Preview {
    CarPlayHome()
}
