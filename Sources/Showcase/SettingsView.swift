// Copyright 2023–2026 Skip
import SwiftUI
import SkipKit
import SkipMarketplace

struct SettingsView: View {
    @Binding var appearance: String
    @AppStorage("statusBarHidden") var statusBarHidden = false

    var body: some View {
        NavigationStack {
            Form {
                // SkipFuseUI 1.14.5 marks LabeledContent inits as unavailable
                // for the bridged surface, so use a plain HStack for the
                // "Skip Mode" row.
                HStack {
                    Text("Skip Mode")
                    Spacer()
                    #if SKIP_FUSE_MODE
                    Text("Fuse (native)")
                        .foregroundStyle(.green)
                    #else
                    Text("Lite (transpiled)")
                        .foregroundStyle(.blue)
                    #endif
                }
                Picker("Appearance", selection: $appearance) {
                    Text("System").tag("")
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }
                Toggle("Hide status bar", isOn: $statusBarHidden)
                NavigationLink("Bill of Materials") {
                    SBOMView(bundle: .module)
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
                    #if os(Android)
                    ComposeView {
                        HeartComposer()
                    }
                    #else
                    Text(verbatim: "💙")
                    #endif
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                       let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                        Text("Version \(version) (\(buildNumber))")
                            .foregroundStyle(.gray)
                    }
                    Text("Powered by [Skip](https://skip.dev)")
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

#if SKIP

struct HeartComposer : ContentComposer {
    @Composable func Compose(context: ComposeContext) {
        androidx.compose.material3.Text("💚", modifier: context.modifier)
    }
}

#endif
