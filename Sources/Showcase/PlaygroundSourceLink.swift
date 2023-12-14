// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
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
