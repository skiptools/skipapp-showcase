// Copyright 2023–2026 Skip
import SwiftUI

struct TextPlayground: View {
    var redaction: RedactionReasons = []
    let markdownVar = "String `var` with markdown"

    /// Lite retains its existing parser API; Apple and Fuse use editable native values.
    private func markdownText(_ source: String) -> Text {
        #if SKIP
        return Text(try! AttributedString(markdown: source))
        #else
        return Text(try! AttributedString(markdown: source, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
        #endif
    }

    #if !SKIP
    private var styledAttributedText: AttributedString {
        var text = AttributedString("Fonts and colors in one Text")
        if let range = text.range(of: "Fonts") {
            text[range].font = .title2.bold()
        }
        if let range = text.range(of: "colors") {
            text[range].foregroundColor = .orange
        }
        if let range = text.range(of: "one Text") {
            text[range].font = .system(.body, design: .monospaced).italic()
            text[range].foregroundColor = .blue
        }
        return text
    }

    private var decoratedAttributedText: AttributedString {
        var text = AttributedString("Underline, strikethrough, and both")
        if let range = text.range(of: "Underline") { text[range].underlineStyle = .single }
        if let range = text.range(of: "strikethrough") { text[range].strikethroughStyle = .single }
        if let range = text.range(of: "both") {
            text[range].underlineStyle = .single
            text[range].strikethroughStyle = .single
        }
        return text
    }

    private var linkedAttributedText: AttributedString {
        var text = AttributedString("Visit Skip or Swift")
        if let range = text.range(of: "Skip") { text[range].link = URL(string: "https://skip.dev") }
        if let range = text.range(of: "Swift") { text[range].link = URL(string: "https://swift.org") }
        return text
    }

    private var superscriptAttributedText: AttributedString {
        var text = AttributedString("E = mc2")
        if let range = text.range(of: "2") {
            text[range].font = .caption
            text[range].baselineOffset = 6
        }
        return text
    }

    private var subscriptAttributedText: AttributedString {
        var text = AttributedString("Water: H2O")
        if let range = text.range(of: "2") {
            text[range].font = .caption
            text[range].baselineOffset = -4
        }
        return text
    }

    private var unicodeAttributedText: AttributedString {
        var text = AttributedString("Unicode 👩🏽‍💻 and cafe\u{301} wrap without splitting their styled ranges.")
        if let range = text.range(of: "👩🏽‍💻 and cafe\u{301}") {
            text[range].foregroundColor = .purple
            text[range].underlineStyle = .single
        }
        return text
    }
    #endif

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

                Text("Markdown").font(.headline)
                markdownText("Markdown\nspanning multiple\nlines")
                markdownText("Markdown *Italic text* including _underscores_")
                markdownText("Markdown **Bold text**")
                markdownText("Markdown ~~Strikethrough text~~")
                markdownText("Markdown `Code text`")
                markdownText("Markdown [Link text](https://skip.dev) and [Another link](https://swift.org)")
                markdownText("Markdown **Bold text** with .italic()")
                    .italic()
                markdownText("Markdown **bold and *italic*** with `code` and ~~strikethrough~~")
                markdownText("  Whitespace: **bold**  text\n\nnext paragraph  ")
                markdownText("Markdown\n\n- Block\n-Elements\n\nare **not** supported")

                Divider()

                Text("Passing a string var does not format as markdown:")
                    .font(.footnote)
                Text(markdownVar)
                Text("Initializing a localized key **does** format as markdown:")
                    .font(.footnote)
                Text(LocalizedStringKey(markdownVar))

                Divider()

                Text("Attributed strings").font(.headline)
                #if !SKIP
                Text(styledAttributedText)
                Text(decoratedAttributedText)
                Text(linkedAttributedText)
                Text(superscriptAttributedText).font(.title2)
                Text(subscriptAttributedText).font(.title2)
                Text(unicodeAttributedText)
                    .frame(width: 220)
                    .border(.secondary)
                Text("Inherited font and color:").font(.footnote)
                Text(AttributedString("This text inherits its surrounding style."))
                    .font(.title3)
                    .foregroundColor(.purple)
                #else
                Text(try! AttributedString(markdown: "Attributed *Italic text* with \("substitution1") and \("substitution2")"))
                Text(try! AttributedString(markdown: "Attributed **Bold text** with .italic()"))
                    .italic()
                #endif

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

                #if SKIP
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
                #endif

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


