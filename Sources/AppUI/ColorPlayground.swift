// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI
import Foundation

struct ColorPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Color", bundle: Bundle.module)
                    .font(.title)
                Divider()

                colorRow(label: Text("Red", bundle: .module), color: .red)
                colorRow(label: Text("Red, .opacity(0.5)", bundle: .module), color: Color.red)
                colorRow(label: Text("RGB", bundle: .module), color: Color(red: 1.0, green: 0.0, blue: 0.0))
                colorRow(label: Text("White, Opacity", bundle: .module), color: Color(white: 0.5, opacity: 1.0))
                colorRow(label: Text("Accent color", bundle: .module), color: .accentColor)
                colorRow(label: Text("Red", bundle: .module), color: .red)
                colorRow(label: Text("Orange", bundle: .module), color: .orange)
                colorRow(label: Text("Yellow", bundle: .module), color: .yellow)
                colorRow(label: Text("Green", bundle: .module), color: .green)
                colorRow(label: Text("Mint", bundle: .module), color: .mint)
                colorRow(label: Text("Teal", bundle: .module), color: .teal)
                colorRow(label: Text("Cyan", bundle: .module), color: .cyan)
                colorRow(label: Text("Blue", bundle: .module), color: .blue)
                colorRow(label: Text("Indigo", bundle: .module), color: .indigo)
                colorRow(label: Text("Purple", bundle: .module), color: .purple)
                colorRow(label: Text("Pink", bundle: .module), color: .pink)
                colorRow(label: Text("Brown", bundle: .module), color: .brown)
                colorRow(label: Text("White", bundle: .module), color: .white)
                colorRow(label: Text("Gray", bundle: .module), color: .gray)
                colorRow(label: Text("Black", bundle: .module), color: .black)
                colorRow(label: Text("Clear", bundle: .module), color: .clear)
                colorRow(label: Text("Primary", bundle: .module), color: .primary)
                colorRow(label: Text("Secondary", bundle: .module), color: .secondary)
            }
        }
        .padding()
    }

    func colorRow(label: Text, color: Color) -> some View {
        HStack {
            label
            Spacer()
            color
                .frame(width: 100.0, height: 100.0)
        }
    }

}
