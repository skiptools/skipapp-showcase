// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct TabViewPlayground: View {
    @State var isPresented = false

    var body: some View {
        TabView {
            Text("Home")
                .tabItem { Label("Home", systemImage: "house.fill") }
            Text("Favorites")
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
            Text("Info")
                .tabItem { Label("Info", systemImage: "info.circle.fill") }
        }
    }
}
