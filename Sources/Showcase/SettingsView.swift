// Copyright 2023–2025 Skip
import Foundation
import SwiftUI

struct SettingsView: View {
    @Binding var appearance: String

    var body: some View {
        NavigationStack {
            Form {
                Picker("Appearance", selection: $appearance) {
                    Text("System").tag("")
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }
                NavigationLink("System Information") {
                    let env = ProcessInfo.processInfo.environment
                    List {
                        ForEach(env.keys.sorted(), id: \.self) { key in
                            HStack {
                                Text(key)
                                Text(env[key] ?? "")
                                    .frame(alignment: .trailing)
                            }
                            .font(Font.caption.monospaced())
                        }
                    }
                    .toolbar {
                        ToolbarItem {
                            Button("System Settings") {
                                Task {
                                    await UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }
                            }
                        }
                    }
                    .navigationTitle("System Information")
                }
                HStack {
                    #if SKIP
                    let powered = "Skip Lite"
                    ComposeView { ctx in // Mix in Compose code!
                        androidx.compose.material3.Text("💚", modifier: ctx.modifier)
                    }
                    #elseif os(Android)
                    let powered = "Skip Fuse"
                    ComposeView {
                        HeartComposer()
                    }
                    #elseif os(iOS)
                    let powered = "SwiftUI and Skip"
                    Text(verbatim: "💙")
                    #endif
                    Text("Powered by [\(powered)](https://skip.tools)")
                }
                HStack {
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                       let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                        Text("Version \(version) (\(buildNumber))")
                            .foregroundStyle(.gray)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#if SKIP
struct HeartComposer : ContentComposer {
    @Composable func Compose(context: ComposeContext) {
        androidx.compose.material3.Text("💚", modifier: context.modifier)
    }
}
#endif
