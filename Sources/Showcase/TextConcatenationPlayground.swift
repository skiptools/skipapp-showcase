// Copyright 2023–2026 Skip
import SwiftUI

/// Demonstrates `Text + Text` concatenation: each operand keeps its own styling, and the result
/// renders as a single flowing run (a Compose `AnnotatedString` on Android) rather than separate views.
struct TextConcatenationPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Per-run color").font(.headline)
                Text("Plain ")
                    + Text("red ").foregroundColor(.red)
                    + Text("green ").foregroundColor(.green)
                    + Text("blue").foregroundColor(.blue)

                Divider()

                Text("Weight, italic, monospaced").font(.headline)
                Text("normal ")
                    + Text("bold ").bold()
                    + Text("heavy ").fontWeight(.heavy)
                    + Text("italic ").italic()
                    + Text("mono").monospaced()

                Divider()

                Text("Mixed font sizes").font(.headline)
                Text("caption ").font(.caption)
                    + Text("body ").font(.body)
                    + Text("title ").font(.title)

                Divider()

                Text("Decorations").font(.headline)
                Text("plain ")
                    + Text("underline ").underline()
                    + Text("strikethrough").strikethrough()

                Divider()

                Text("Gradient foreground").font(.headline)
                Text("solid ")
                    + Text("gradient run")
                        .foregroundStyle(LinearGradient(colors: [.blue, .purple, .pink], startPoint: .leading, endPoint: .trailing))
                        .bold()

                Divider()

                Text("Combined styles + wrapping").font(.headline)
                Text("This ").foregroundColor(.orange).bold()
                    + Text("concatenated ").italic()
                    + Text("text ").underline()
                    + Text("mixes several styles and wraps across multiple lines as one paragraph").foregroundColor(.secondary)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "TextConcatenationPlayground.swift")
        }
    }
}
