// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct GradientPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text(".red.gradient")
                    Spacer()
                    Rectangle()
                        .fill(.red.gradient)
                        .frame(width: 100.0, height: 100.0)
                }
                HStack {
                    Text("EllipitcalGradient")
                    Spacer()
                    EllipticalGradient(colors: [.red, .blue], center: UnitPoint(x: 0.5, y: 0.5), startRadiusFraction: 0.25)
                        .frame(width: 50.0, height: 100.0)
                }
                HStack {
                    Text("LinearGradient")
                    Spacer()
                    LinearGradient(colors: [.red, .blue], startPoint: UnitPoint(x: 0.0, y: 0.0), endPoint: UnitPoint(x: 1.0, y: 1.0))
                        .frame(width: 100.0, height: 100.0)
                }
                HStack {
                    Text("RadialGradient")
                    Spacer()
                    RadialGradient(colors: [.red, .blue], center: UnitPoint(x: 0.5, y: 0.5), startRadius: 25.0, endRadius: 50.0)
                        .frame(width: 100.0, height: 100.0)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GradientPlayground.swift")
        }
    }
}
