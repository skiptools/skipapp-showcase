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
                LabeledContent(content: {
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                       let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                        Text("\(version) (\(buildNumber))")
                            .foregroundStyle(.gray)
                    }
                }, label: {
                    #if SKIP_MODE_FUSE
                    let mode = "Fuse"
                    #else
                    let mode = "Lite"
                    #endif
                    Text("Powered by [Skip \(mode)](https://skip.dev)")
                })

                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        #if SKIP
                        // Skip Lite (transpiled) can inline Compose calls directly
                        ComposeView { ctx in
                            androidx.compose.material3.Text("💚", modifier: ctx.modifier)
                        }
                        #elseif os(Android)
                        // Skip Fuse (compiled) uses ComposeView to bridge into the transpiled code in the SKIP block below
                        ComposeView {
                            HeartComposer()
                        }
                        #else
                        Text(verbatim: "💙")
                        #endif
                    }
                    Spacer()
                }
                .onTapGesture {
                    let reqested = Marketplace.current.requestReview(period: .days(0))
                    logger.info("requesting marketplace review: \(reqested)")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#if SKIP

struct HeartComposer: ContentComposer {
    @Composable func Compose(context: ComposeContext) {
        androidx.compose.material3.Text("💚", modifier: context.modifier)
    }
}

#endif
