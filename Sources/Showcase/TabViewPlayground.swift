// Copyright 2023–2025 Skip
import SwiftUI

struct TabViewPlayground: View {
    @State var selectedTab = "Home"

    var body: some View {
        if #available(iOS 18.4, *) {
            TabView(selection: $selectedTab) {
                Tab("Home", systemImage: "house.fill", value: "Home") {
                    TabPlaygroundContentView(label: "Home", selectedTab: $selectedTab)
                }
                Tab("Favorites", systemImage: "heart.fill", value: "Favorites") {
                    TabView {
                        TabPlaygroundContentView(label: "Favorites (page 1)", selectedTab: $selectedTab)
                            .padding(32)
                            .background {
                                Capsule()
                                    .fill(Color.pink.opacity(0.1))
                            }
                        Text("More (page 2)")
                    }
                    #if !os(macOS) || os(Android)
                    .tabViewStyle(.page)
                    #endif
                }
                #if !os(macOS) || os(Android)
                Tab("Paging", systemImage: "arrow.forward.square", value: "Paging") {
                    TabPageViewContentView()
                }
                #endif
                TabSection {
                    Tab(value: "Search", role: .search) {
                        Text("Search Tab")
                    }
                    Tab("Hidden", systemImage: "plus", value: "Hidden") {
                        Text("Hidden Tab")
                    }
                    .hidden(true)
                    Tab("Disabled", systemImage: "xmark", value: "Disabled") {
                        Text("Disabled Tab")
                    }
                    .disabled(true)
                }
            }
            .tint(.red)
            .toolbar {
                PlaygroundSourceLink(file: "TabViewPlayground.swift")
            }
        } else {
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
                #if !os(macOS) || os(Android)
                .tabViewStyle(.page)
                #endif
                .tabItem { Label("Favorites", systemImage: "heart.fill") }
                .tag("Favorites")
                #if !os(macOS) || os(Android)
                TabPageViewContentView()
                    .tabItem { Label("Paging", systemImage: "arrow.forward.square") }
                    .tag("Paging")
                #endif
            }
            .tint(.red)
            .toolbar {
                PlaygroundSourceLink(file: "TabViewPlayground.swift")
            }
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
            #if !os(macOS) || os(Android)
            if label != "Paging" {
                Button("Switch to Paging") {
                    selectedTab = "Paging"
                }
            }
            #endif
        }
    }
}

#if os(macOS)
#else
struct TabPageViewContentView: View {
    @State var selection = 2

    var body: some View {
        ScrollView {
            VStack {
                TabView(selection: $selection) {
                    Rectangle()
                        .fill(.gray)
                        .overlay {
                            Text("This is a horizontally swipable paging TabView")
                                .padding()
                        }
                        .tag(1)
                    Rectangle()
                        .fill(.blue)
                        .overlay {
                            Text("Page 2")
                                .padding()
                        }
                        .tag(2)
                    Rectangle()
                        .fill(.green)
                        .overlay {
                            Text("I heard you like TabViews so we put a TabView inside your TabView inside your TabView")
                                .padding()
                        }
                        .tag(3)
                }
                .frame(height: 128)
                Text("Current Page: \(selection)")
                    .foregroundStyle(.gray)
                Button("Scroll to Page 2") {
                    withAnimation { selection = 2 }
                }
                .buttonStyle(.bordered)
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
