// Copyright 2023–2025 Skip
import SwiftUI
import SkipKit

struct WebBrowserPlayground: View {
    let skipURL = URL(string: "https://skip.dev")!
    @State var showEmbedded = false
    @State var showEmbeddedNoParams = false
    @State var showLaunchBrowser = false
    @State var showCustomActions = false
    @State var showAllOptions = false
    @State var useNavigationPresentation = false

    var presentationMode: WebBrowserPresentationMode {
        useNavigationPresentation ? .navigation : .sheet
    }

    var body: some View {
        List {
            Section("Presentation Mode") {
                Toggle("Sheet / Navigation", isOn: $useNavigationPresentation)
            }

            Section("Embedded Browser") {
                Button("Open in Embedded Browser") {
                    showEmbedded = true
                }
                .openWebBrowser(isPresented: $showEmbedded, url: skipURL, mode: .embeddedBrowser(params: EmbeddedParams(presentationMode: presentationMode)))

                Button("Open with No Params") {
                    showEmbeddedNoParams = true
                }
                .openWebBrowser(isPresented: $showEmbeddedNoParams, url: skipURL.appendingPathComponent("docs"), mode: .embeddedBrowser(params: EmbeddedParams(presentationMode: presentationMode)))
            }

            Section("Launch Browser") {
                Button("Open in System Browser") {
                    showLaunchBrowser = true
                }
                .openWebBrowser(isPresented: $showLaunchBrowser, url: skipURL, mode: .launchBrowser)
            }

            Section("Custom Actions") {
                Button("With Custom Action") {
                    showCustomActions = true
                }
                .openWebBrowser(isPresented: $showCustomActions, url: skipURL, mode: .embeddedBrowser(params: EmbeddedParams(
                    presentationMode: presentationMode,
                    customActions: [
                        WebBrowserAction(label: "Log URL") { url in
                            logger.info("Custom action URL: \(url)")
                        }
                    ]
                )))
            }

            Section("All Options") {
                Button("Actions") {
                    showAllOptions = true
                }
                .openWebBrowser(isPresented: $showAllOptions, url: skipURL, mode: .embeddedBrowser(params: EmbeddedParams(
                    presentationMode: presentationMode,
                    customActions: [
                        WebBrowserAction(label: "Share URL") { url in
                            logger.info("Share: \(url)")
                        },
                        WebBrowserAction(label: "Bookmark") { url in
                            logger.info("Bookmark: \(url)")
                        }
                    ]
                )))
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "WebBrowserPlayground.swift")
        }
    }
}
