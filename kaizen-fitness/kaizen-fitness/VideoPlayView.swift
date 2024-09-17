import SwiftUI
import WebKit

struct VideoPlayView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // mute有効にしないと自動で再生開始されないのはそういう仕様らしい
        let embedHTML = """
        <iframe width="100%" height="100%" src="https://www.youtube.com/embed/\(videoID)?autoplay=1&mute=1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        """
        uiView.loadHTMLString(embedHTML, baseURL: nil)
    }
}

#Preview {
    VideoPlayView(videoID: "hge3fr50o0o")
}
