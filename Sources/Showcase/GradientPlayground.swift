// Copyright 2023–2025 Skip
import SwiftUI

struct GradientPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text(".red.gradient")
                    Spacer()
                    Rectangle()
                        .fill(.red.gradient)
                        .frame(width: 100, height: 100)
                }
                HStack {
                    Text("EllipitcalGradient")
                    Spacer()
                    EllipticalGradient(colors: [.red, .blue], center: UnitPoint(x: 0.5, y: 0.5), startRadiusFraction: 0.25)
                        .frame(width: 50, height: 100)
                }
                HStack {
                    Text("LinearGradient")
                    Spacer()
                    LinearGradient(colors: [.red, .blue], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
                        .frame(width: 100, height: 100)
                }
                HStack {
                    Text("RadialGradient")
                    Spacer()
                    RadialGradient(colors: [.red, .blue], center: UnitPoint(x: 0.5, y: 0.5), startRadius: 25, endRadius: 50)
                        .frame(width: 100, height: 100)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GradientPlayground.swift")
        }
    }
}
