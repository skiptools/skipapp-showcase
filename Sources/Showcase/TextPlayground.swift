// Copyright 2023–2025 Skip
import SwiftUI

struct TextPlayground: View {
    var redaction: RedactionReasons = []
    let markdownVar = "String `var` with markdown"

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Plain")
                Text("Bold").bold()
                Text("Italic").italic()
                Text("Title bold italic").font(.title).bold().italic()
                Text("Strikethrough").strikethrough()
                Text("Underline").underline()
                VStack {
                    Text("Thin footnote container")
                    Text("Overridden to title font").font(.title)
                }
                .font(.footnote).fontWeight(.thin)
                .border(.primary)

                Divider()

                Text("Custom Font")
                    .font(Font.custom("Protest Guerrilla", size: 30.0)) // protest_guerrilla.ttf

                Divider()

                Text("Font.largeTitle").font(.largeTitle)
                Text("Font.title").font(.title)
                Text("Font.title2").font(.title2)
                Text("Font.title3").font(.title3)
                Text("Font.headline").font(.headline)
                Text("Font.subheadline").font(.subheadline)
                Text("Font.body").font(.body)
                Text("Font.callout").font(.callout)
                Text("Font.footnote").font(.footnote)
                Text("Font.caption").font(.caption)
                Text("Font.caption2").font(.caption2)

                Divider()

                Text("Markdown\nspanning multiple\nlines")
                Text("Markdown *Italic text* including _underscores_")
                Text("Markdown **Bold text**")
                Text("Markdown ~~Strikethrough text~~")
                Text("Markdown `Code text`")
                Text("Markdown [Link text](https://skip.tools) and [\("Another link")](\("https://swift.org"))")
                Text("Markdown **Bold text** with .italic()")
                    .italic()
                Text("Markdown **bold** \("**String interpolation**") is not formatted")
                Text("Markdown\n\n- Block\n-Elements\n\nare **not** supported")

                Divider()

                Text("Passing a string var does not format as markdown:")
                    .font(.footnote)
                Text(markdownVar)
                Text("Initializing a localized key **does** format as markdown:")
                    .font(.footnote)
                Text(LocalizedStringKey(markdownVar))

                Divider()

                Text(try! AttributedString(markdown: "Attributed *Italic text* with \("substitution1") and \("substitution2")"))
                Text(try! AttributedString(markdown: "Attributed **Bold text** with .italic()"))
                    .italic()

                Divider()

                Text("Wrap: This is some long text that should wrap when it exceeds the width of its frame")
                    .frame(width: 200)
                    .border(Color.blue)
                Text("multilineTextAlignment: This is some long text that should wrap when it exceeds the width of its frame")
                    .frame(width: 200)
                    .multilineTextAlignment(.center)
                    .border(Color.blue)
                Text(".lineLimit(1): This is some long text that should wrap when it exceeds the width of its frame")
                    .lineLimit(1)
                    .frame(width: 200)
                    .border(Color.blue)
                Text(".truncationMode(.middle): This is some long text that should middle truncate when it exceeds the width of its frame")
                    .truncationMode(.middle)
                    .lineLimit(1)
                    .frame(width: 200)
                    .border(Color.blue)
                Text(".truncationMode(.tail): This is some long text when it exceeds the width of its frame will head truncate")
                    .truncationMode(.head)
                    .lineLimit(1)
                    .frame(width: 200)
                    .border(Color.blue)

                Divider()

                Text("Font.largeTitle: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.largeTitle)
                    .padding()
                Text("Font.title: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.title)
                    .padding()
                Text("Font.title2: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.title2)
                    .padding()
                Text("Font.title3: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.title3)
                    .padding()
                Text("Font.headline: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.headline)
                    .padding()
                Text("Font.subheadline: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.subheadline)
                    .padding()
                Text("Font.body: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.body)
                    .padding()
                Text("Font.callout: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.callout)
                    .padding()
                Text("Font.footnote: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.footnote)
                    .padding()
                Text("Font.caption: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.caption)
                    .padding()
                Text("Font.caption2: This is some long text that we use to preview the default line spacing under different fonts. The quick brown fox jumped over the lazy dog.")
                    .font(.caption2)
                    .padding()
            }
            .padding()
        }
        .redacted(reason: redaction)
        .toolbar {
            PlaygroundSourceLink(file: "TextPlayground.swift")
        }
    }
}
