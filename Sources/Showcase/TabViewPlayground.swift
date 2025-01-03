// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct TabViewPlayground: View {
    @State var selectedTab = "Home"

    var body: some View {
        TabView(selection: $selectedTab) {
            TabPlaygroundContentView(label: "Home", selectedTab: $selectedTab)
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag("Home")
            TabView {
                TabPlaygroundContentView(label: "Favorites (page 1)", selectedTab: $selectedTab)
                    .padding(32)
                    .background {
                        Capsule()
                            .fill(Color.pink.opacity(0.1))
                    }
                Text("More (page 2)")
            }
            .tabViewStyle(.page)
            .tabItem { Label("Favorites", systemImage: "heart.fill") }
            .tag("Favorites")
            TabPageViewContentView()
                .tabItem { Label("Paging", systemImage: "arrow.forward.square") }
                .tag("Paging")
        }
        .tint(.red)
        .toolbar {
            PlaygroundSourceLink(file: "TabViewPlayground.swift")
        }
    }
}

struct TabPlaygroundContentView: View {
    let label: String
    @Binding var selectedTab: String

    var body: some View {
        VStack {
            Text(label).bold()
            if label != "Home" {
                Button("Switch to Home") {
                    selectedTab = "Home"
                }
            }
            if label != "Favorites" {
                Button("Switch to Favorites") {
                    selectedTab = "Favorites"
                }
            }
            if label != "Paging" {
                Button("Switch to Paging") {
                    selectedTab = "Paging"
                }
            }
        }
    }
}

#if os(macOS)
#else
struct TabPageViewContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                TabView {
                    Rectangle()
                        .fill(.gray)
                        .overlay {
                            Text("This is a horizontally swipable paging TabView")
                                .padding()
                        }
                    Rectangle()
                        .fill(.blue)
                        .overlay {
                            Text("Page 2")
                                .padding()
                        }
                    Rectangle()
                        .fill(.green)
                        .overlay {
                            Text("I heard you like TabViews so we put a TabView inside your TabView inside your TabView")
                                .padding()
                        }
                }
                .frame(height: 128)
                TabView {
                    Image(systemName: "heart")
                        .resizable()
                        .background(.teal)
                    Image(systemName: "heart.fill")
                        .resizable()
                        .background(.red)
                }
                .aspectRatio(2, contentMode: .fill)
                TabView {
                    Rectangle()
                        .fill(.mint)
                        .overlay {
                            Text("Single page with indicator showing")
                        }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(height: 128)
                TabView {
                    Rectangle()
                        .fill(.green)
                        .overlay {
                            Text("Multi page with indicator hidden")
                        }
                    Text("Page 2")
                        .background(.red)
                        .padding()
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 128)
            }
            .tabViewStyle(.page)
            .foregroundStyle(Color.white)
        }
    }
}
#endif
