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
        }
    }
}

#Preview {
    ContentView()
}
