// Copyright 2023–2025 Skip
import SwiftUI

struct ZIndexPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Without zIndex")
                    Spacer()
                    ZStack {
                        Color.blue.opacity(0.5)
                            .frame(width: 20, height: 20)
                        Color.green.opacity(0.5)
                            .frame(width: 60, height: 60)
                        Color.red.opacity(0.5)
                            .frame(width: 100, height: 100)
                    }
                }
                HStack {
                    Text("With zIndex")
                    Spacer()
                    ZStack {
                        Color.blue.opacity(0.5)
                            .frame(width: 20, height: 20)
                            .zIndex(2)
                        Color.green.opacity(0.5)
                            .frame(width: 60, height: 60)
                            .zIndex(1)
                        Color.red.opacity(0.5)
                            .frame(width: 100, height: 100)
                    }
                }
                HStack {
                    Text("With zIndex before frame")
                    Spacer()
                    ZStack {
                        Color.blue.opacity(0.5)
                            .zIndex(2)
                            .frame(width: 20, height: 20)
                        Color.green.opacity(0.5)
                            .zIndex(1)
                            .frame(width: 60, height: 60)
                        Color.red.opacity(0.5)
                            .frame(width: 100, height: 100)
                    }
                }
            }
            .padding()
        }
    }
}
