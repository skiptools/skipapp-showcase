// Copyright 2025 Skip
import SwiftUI
import SkipWeb

/// This component uses the `SkipWeb` module from https://source.skip.tools/skip-web
struct WebViewPlayground: View {
    @State var config = WebEngineConfiguration()
    @State var navigator = WebViewNavigator()
    @State var state = WebViewState()
    @State var showScriptSheet = false
    @State var javaScriptInput = "document.body.innerText"
    @State var javaScriptOutput = ""

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

            Button {
                self.showScriptSheet = true
            } label: {
                Image(systemName: "ellipsis")
            }
            .accessibilityLabel(Text("Evaluate JavaScript"))
        }
        .navigationTitle(state.pageTitle ?? "WebView")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showScriptSheet) {
            NavigationStack {
                VStack {
                    TextField("JavaScript", text: $javaScriptInput)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .keyboardType(.asciiCapable) // also disables smart quotes
                        .textInputAutocapitalization(.never)
                        .onSubmit(of: .text) { evaluateJavaScript() }
                        .padding()
                    Text("Output")
                        .font(.headline)
                    TextEditor(text: $javaScriptOutput)
                        .font(Font.body.monospaced())
                        .border(Color.secondary)
                        .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Evaluate Script") {
                            evaluateJavaScript()
                        }
                        .disabled(javaScriptInput.isEmpty)
                    }

                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close", role: .cancel) {
                            showScriptSheet = false
                        }
                    }
                }
            }
        }
    }

    /// Evaluate the script specified in the sheet
    func evaluateJavaScript() {
        let navigator = self.navigator
        Task {
            var scriptResult: String = ""
            do {
                if let resultJSON = try await navigator.evaluateJavaScript(javaScriptInput) {
                    // top-level fragments are nicer to display as strings, so we try to deserialize them
                    if let topLevelString = try? JSONSerialization.jsonObject(with: resultJSON.data(using: .utf8)!, options: .fragmentsAllowed) as? String {
                        scriptResult = topLevelString
                    } else {
                        scriptResult = resultJSON
                    }
                }
            } catch {
                scriptResult = error.localizedDescription
            }
            Task { @MainActor in
                self.javaScriptOutput = scriptResult
            }
        }
    }
}
