// Copyright 2023–2025 Skip
import Foundation
import SwiftUI
import SkipKit

/// Displays a link to the source code for the given playground type.
struct PlaygroundSourceLink : View {
    @AppStorage("openLinksExternally") var openLinksExternally = false
    @State var showSource = false
    private let destination: URL

    init(file: String) {
        destination = URL(string: showcaseSourceURLString + playgroundPath + file)!
    }

    var body: some View {
        Button("Source") {
            showSource = true
        }.openWebBrowser(isPresented: $showSource, url: destination, mode: openLinksExternally ? .launchBrowser : .embeddedBrowser(params: nil))
    }
}
