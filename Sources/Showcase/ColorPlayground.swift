// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ColorPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                colorRow(label: Text("Red"), color: .red)
                colorRow(label: Text("Red, .opacity(0.5)"), color: Color.red.opacity(0.5))
                colorRow(label: Text("RGB"), color: Color(red: 1, green: 0, blue: 0))
                colorRow(label: Text("HSV"), color: Color(hue: 0.5, saturation: 0.75, brightness: 0.5))
                colorRow(label: Text("White, Opacity"), color: Color(white: 0.5, opacity: 1))
                colorRow(label: Text("Accent color"), color: .accentColor)
                colorRow(label: Text("Red"), color: .red)
                colorRow(label: Text("Orange"), color: .orange)
                colorRow(label: Text("Yellow"), color: .yellow)
                colorRow(label: Text("Green"), color: .green)
                colorRow(label: Text("Mint"), color: .mint)
                colorRow(label: Text("Teal"), color: .teal)
                colorRow(label: Text("Cyan"), color: .cyan)
                colorRow(label: Text("Blue"), color: .blue)
                colorRow(label: Text("Indigo"), color: .indigo)
                colorRow(label: Text("Purple"), color: .purple)
                colorRow(label: Text("Pink"), color: .pink)
                colorRow(label: Text("Brown"), color: .brown)
                colorRow(label: Text("White"), color: .white)
                colorRow(label: Text("Gray"), color: .gray)
                colorRow(label: Text("Black"), color: .black)
                colorRow(label: Text("Clear"), color: .clear)
                colorRow(label: Text("Primary"), color: .primary)
                colorRow(label: Text("Secondary"), color: .secondary)
                colorRow(label: Text("#colorLiteral"), color: Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ColorPlayground.swift")
        }
    }

    func colorRow(label: Text, color: Color) -> some View {
        HStack {
            label
            Spacer()
            color
                .frame(width: 100, height: 100)
        }
    }
}
