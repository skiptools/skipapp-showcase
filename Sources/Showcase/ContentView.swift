// Copyright 2023–2026 Skip
import SwiftUI

enum ContentTab: String, Hashable {
    case about, showcase, settings
}

struct ContentView: View {
    @AppStorage("tab") var tab = ContentTab.about
    @AppStorage("appearance") var appearance = ""
    @AppStorage("statusBarHidden") var statusBarHidden = false

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
        // statusBarHidden is marked unavailable in the SkipFuseUI 1.14.5
        // bridge and is also flagged by the Lite transpiler, so apply it only
        // when neither restriction is in effect.
        #if !SKIP_FUSE_MODE && !SKIP
        .statusBarHidden(statusBarHidden)
        #endif
    }
}
