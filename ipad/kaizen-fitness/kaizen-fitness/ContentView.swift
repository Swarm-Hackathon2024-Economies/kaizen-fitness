//
//  ContentView.swift
//  kaizen-fitness
//
//  Created by takuya on 9/12/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        TabView {
            Map {
                
            }
            .tabItem {
                VStack {
                    Image(systemName: "flag.fill")
                    Text("test")
                }
            }
            VideoPlayView(videoID: "hge3fr50o0o")
                .frame(height: 300)
                .cornerRadius(12)
                .shadow(radius: 5)
                .tabItem {
                    VStack {
                        Image(systemName: "movieclapper")
                        Text("Video")
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
