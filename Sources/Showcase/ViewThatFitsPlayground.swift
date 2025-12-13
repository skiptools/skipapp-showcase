// Copyright 2023–2025 Skip
import SwiftUI

struct ViewThatFitsPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("ViewThatFits (default: both axes)").bold()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Constraint: 140×40").font(.caption)
                    ZStack {
                        Color.black.opacity(0.1)
                        ViewThatFits {
                            Color.red.frame(width: 220, height: 30)
                            Color.green.frame(width: 120, height: 30)
                        }
                    }
                    .frame(width: 140, height: 40)
                    .border(.blue)
                }

                Text("ViewThatFits(in: .horizontal)").bold()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Constraint: width 160").font(.caption)
                    ZStack {
                        Color.black.opacity(0.1)
                        ViewThatFits(in: .horizontal) {
                            Text("This is a much longer string that likely won't fit.")
                                .padding(6)
                                .background(Color.red.opacity(0.4))
                            Text("Short")
                                .padding(6)
                                .background(Color.green.opacity(0.4))
                        }
                    }
                    .frame(width: 160)
                    .border(.blue)
                }

                Text("ViewThatFits(in: .vertical)").bold()
                VStack(alignment: .leading, spacing: 8) {
                    Text("Constraint: height 44").font(.caption)
                    ZStack {
                        Color.black.opacity(0.1)
                        ViewThatFits(in: .vertical) {
                            Color.red.frame(width: 120, height: 120)
                            Color.green.frame(width: 120, height: 30)
                        }
                    }
                    .frame(height: 44)
                    .border(.blue)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ViewThatFitsPlayground.swift")
        }
    }
}


