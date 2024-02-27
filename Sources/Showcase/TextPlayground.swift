// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct TextPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Plain")
                Text("Bold").bold()
                Text("Italic").italic()
                Text("Title bold italic").font(.title).bold().italic()
                VStack {
                    Text("Thin footnote container")
                    Text("Overridden to title font").font(.title)
                }
                .font(.footnote).fontWeight(.thin)
                .border(.primary)

                Divider()

                text("Font.largeTitle", with: .largeTitle)
                text("Font.title", with: .title)
                text("Font.title2", with: .title2)
                text("Font.title3", with: .title3)
                text("Font.headline", with: .headline)
                text("Font.subheadline", with: .subheadline)
                text("Font.body", with: .body)
                text("Font.callout", with: .callout)
                text("Font.footnote", with: .footnote)
                text("Font.caption", with: .caption)
                text("Font.caption2", with: .caption2)

                Divider()

                Text("Wrap: This is some long text that should wrap when it exceeds the width of its frame")
                    .frame(width: 200)
                    .border(Color.blue)
                Text(".lineLimit(1): This is some long text that should wrap when it exceeds the width of its frame")
                    .lineLimit(1)
                    .frame(width: 200)
                    .border(Color.blue)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "TextPlayground.swift")
        }
    }

    // Test that the .font modifier (along with many others) returns Text rather than any View
    private func text(_ text: String, with font: Font) -> Text {
        return Text(text).font(font)
    }
}
