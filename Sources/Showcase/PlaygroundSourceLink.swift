// Copyright 2023–2025 Skip
import SwiftUI

/// Displays a link to the source code for the given playground type.
struct PlaygroundSourceLink : View {
    private let destination: URL

    init(file: String) {
        destination = URL(string: showcaseSourceURLString + playgroundPath + file)!
    }

    var body: some View {
        Link("Source", destination: destination)
    }
}
