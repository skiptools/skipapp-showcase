// Copyright 2025 Skip
import SwiftUI
import SkipWeb

/// This component uses the `SkipWeb` module from https://source.skip.tools/skip-web
struct WebViewPlayground: View {
    @State var config = WebEngineConfiguration()
    @State var navigator = WebViewNavigator()
    @State var state = WebViewState()

    var body: some View {
        VStack {
            WebView(configuration: config, navigator: navigator, url: URL(string: "https://skip.tools")!, state: $state)
        }
        .toolbar {
            Button {
                navigator.goBack()
            } label: {
                Image(systemName: "arrow.left")
            }
            .disabled(!state.canGoBack)
            .accessibilityLabel(Text("Back"))

            Button {
                navigator.reload()
            } label: {
                Image(systemName: "arrow.clockwise.circle")
            }
            .accessibilityLabel(Text("Reload"))

            Button {
                navigator.goForward()
            } label: {
                Image(systemName: "arrow.forward")
            }
            .disabled(!state.canGoForward)
            .accessibilityLabel(Text("Forward"))
        }
        .navigationTitle(state.pageTitle ?? "WebView")
        .navigationBarTitleDisplayMode(.inline)
    }
}
