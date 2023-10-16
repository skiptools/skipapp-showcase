// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct TabViewPlayground: View {
    var body: some View {
        TabView {
            Text("Tab 1")
                .tabItem { Text("Tab 1") }
            Text("Favorites")
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
            Text("Tab 3")
                .tabItem { Text("Tab 3") }
        }
    }
}
