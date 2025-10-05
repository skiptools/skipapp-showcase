// Copyright 2023–2025 Skip
import SwiftUI
import SkipKit
import SkipMarketplace

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
                    ComposeView { ctx in // Mix in Compose code!
                        androidx.compose.material3.Text("💚", modifier: ctx.modifier)
                    }
                    #else
                    Text(verbatim: "💙")
                    #endif
                    if let version = ProcessInfo.processInfo.appVersionString,
                       let buildNumber = ProcessInfo.processInfo.appVersionNumber {
                        Text("Version \(version) (\(buildNumber))")
                            .foregroundStyle(.gray)
                    }
                    Text("Powered by [Skip](https://skip.tools)")
                }
                .onTapGesture {
                    logger.info("requesting marketplace review")
                    Marketplace.current.requestReview(period: .days(0))
                }
            }
            .navigationTitle("Settings")
        }
    }
}
