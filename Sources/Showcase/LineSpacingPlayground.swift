// Copyright 2023–2026 Skip
import SwiftUI

struct LineSpacingPlayground: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Group {
                    Text("Default (no lineSpacing)")
                        .font(.headline)
                    Text("This is a multi-line text that demonstrates the default line spacing. Notice how the lines are spaced normally without any additional spacing applied.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Group {
                    Text("lineSpacing: 5")
                        .font(.headline)
                    Text("This is a multi-line text with lineSpacing of 5 points. Notice the slightly increased space between each line of text.")
                        .lineSpacing(5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Group {
                    Text("lineSpacing: 10")
                        .font(.headline)
                    Text("This is a multi-line text with lineSpacing of 10 points. The lines are now more spread out, making the text easier to read.")
                        .lineSpacing(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Group {
                    Text("lineSpacing: 20")
                        .font(.headline)
                    Text("This is a multi-line text with lineSpacing of 20 points. Very large line spacing creates significant gaps between lines.")
                        .lineSpacing(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Group {
                    Text("Large font + lineSpacing: 15")
                        .font(.headline)
                    Text("Large title with extra line spacing applied to demonstrate the effect on bigger text.")
                        .font(.title)
                        .lineSpacing(15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "LineSpacingPlayground.swift")
        }
    }
}
