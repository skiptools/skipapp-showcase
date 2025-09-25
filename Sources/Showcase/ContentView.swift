// Copyright 2023–2025 Skip
import SwiftUI

enum ContentTab: String, Hashable {
    case about, showcase, settings
}

struct ContentView: View {
    @AppStorage("tab") var tab = ContentTab.about
    @AppStorage("appearance") var appearance = ""

    var body: some View {
        TabView(selection: $tab) {
            AboutView()
                .tag(ContentTab.about)
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
            PlaygroundNavigationView()
                .tag(ContentTab.showcase)
                .tabItem {
                    Label {
                        Text("Showcase")
                    } icon: {
                        Image("widgets", bundle: .module, label: Text("Showcase Icon"))
                    }
                }
            SettingsView(appearance: $appearance)
                .tag(ContentTab.settings)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}
