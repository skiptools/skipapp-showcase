// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
            PlaygroundNavigationView()
                .tabItem {
                    Label("Showcase", systemImage: "list.bullet")
                }
        }
    }
}
