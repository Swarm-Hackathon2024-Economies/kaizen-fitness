//
//  DriveScreen.swift
//  kaizen-fitness
//
//  Created by takuya on 9/12/24.
//

import SwiftUI
import AVFoundation

struct DriveScreen: View {
    @State private var images: [Image] = []
    @State private var gifCount: Int = 0
    @State private var currentIndex: Int = 0
    @State private var isTraffic: Bool = false

    private let ThemeSound = try!  AVAudioPlayer(data: NSDataAsset(name: "WeSportsTheme")!.data)
    private func playSound(){
        ThemeSound.setVolume(0.5, fadeDuration: 3.0)
        ThemeSound.play()
    }

    private func stopSound(){
        ThemeSound.stop()
    }

    var gifName: String
    var minimumInterval: Double

    var body: some View {
        if isTraffic {
            VStack {
                Button("渋滞抜けた！！！！") {
                    self.isTraffic = false
                }
            }
            VideoPlayView(videoID: "hge3fr50o0o")
                .cornerRadius(12)
                .shadow(radius: 5)
        } else {
            VStack {
                Text("運転中〜〜〜")
                Button("音を止める") {
                    stopSound()
                }
                Button("渋滞にハマった！！！！") {
                    self.isTraffic = true
                }
                TimelineView(.animation(minimumInterval: minimumInterval)) { context in
                    Group {
                        if images.isEmpty {
                            Text("エラー")
                        } else {
                            images[currentIndex]
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    .onChange(of: context.date) {
                        if currentIndex == (gifCount - 1) {
                            currentIndex = 0
                        } else {
                            currentIndex += 1
                        }
                    }
                }
                .onAppear {
                    guard let bundleURL = Bundle.main.url(forResource: gifName, withExtension: "gif"),
                          let gifData = try? Data(contentsOf: bundleURL),
                          let source = CGImageSourceCreateWithData(gifData as CFData, nil)
                    else {
                        return
                    }
                    gifCount = CGImageSourceGetCount(source)
                    var cgImages: [CGImage?] = []
                    for i in 0..<gifCount {
                        cgImages.append(CGImageSourceCreateImageAtIndex(source, i, nil))
                    }
                    let uiImages = cgImages.compactMap({ $0 }).map({ UIImage(cgImage: $0) })
                    images = uiImages.map({ Image(uiImage: $0) })

                    playSound()
                }
                .onDisappear {
                    stopSound()
                }
                .frame(width: 500)
            }
        }
    }
}

#Preview {
    DriveScreen(gifName: "car", minimumInterval: 0.03)
}

