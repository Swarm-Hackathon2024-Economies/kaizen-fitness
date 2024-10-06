import SwiftUI
import AVFoundation

struct ShoutView: View {
    @StateObject private var audioRecorder = AudioRecorder()

    var body: some View {
        VStack {
            Circle()
                .frame(width: audioRecorder.circleSize, height: audioRecorder.circleSize)
                .foregroundColor(.blue)
                .animation(.easeInOut, value: audioRecorder.circleSize) // アニメーションで滑らかにサイズを変更

            Text("声の大きさで円のサイズが変わります")
                .padding()
        }
        .onAppear {
            audioRecorder.startRecording()
        }
        .onDisappear {
            audioRecorder.stopRecording()
        }
    }
}

class AudioRecorder: NSObject, ObservableObject {
    private var audioRecorder: AVAudioRecorder!
    private var timer: Timer?

    @Published var circleSize: CGFloat = 100.0

    override init() {
        super.init()
        setupAudioRecorder()
    }

    private func setupAudioRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            try audioSession.setActive(true)

            let url = URL(fileURLWithPath: "/dev/null")
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatAppleLossless),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
            ]

            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder.isMeteringEnabled = true
        } catch {
            print("Audio setup failed: \(error.localizedDescription)")
        }
    }

    func startRecording() {
        audioRecorder.record()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.updateCircleSize()
        }
    }

    func stopRecording() {
        audioRecorder.stop()
        timer?.invalidate()
    }

    private func updateCircleSize() {
        audioRecorder.updateMeters()
        let power = audioRecorder.averagePower(forChannel: 0)
        let scaleFactor = max(0, CGFloat(power + 50) / 50) // 0から1の範囲にスケール
        let newSize = 100 + scaleFactor * 200 // 基本サイズ100、最大300まで拡大
        DispatchQueue.main.async {
            self.circleSize = newSize
        }
    }
}

#Preview {
    ShoutView()
}
