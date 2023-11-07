// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ShapePlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Circle").font(.title).bold()
                HStack {
                    Text("fill()")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill()
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("fill()")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill()
                    }
                    .frame(width: 50.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("fill(.red)")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(.red)
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("fill(.red.gradient)")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(.red.gradient)
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("stroke()")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke()
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("stroke(.red, lineWidth: 10)")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(.red, lineWidth: 10.0)
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("stroke(.red.gradient, lineWidth: 10)")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(.red.gradient, style: StrokeStyle(lineWidth: 10.0))
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("stroke(.red,\n    style: StrokeStyle(\n    lineWidth: 10.0,\n      dash: [10]))")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(.red, style: StrokeStyle(lineWidth: 10.0, dash: [10.0]))
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("strokeBorder(.red, lineWidth: 10)")
                    Spacer()
                    ZStack {
                        Circle()
                            .strokeBorder(.red, lineWidth: 10.0)
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("fill(.red)\n  .stroke(.green, lineWidth: 10)")
                    Spacer()
                    ZStack {
                        if #available(iOS 17, *) {
                            Circle()
                                .fill(.red)
                                .stroke(.green, lineWidth: 10.0)
                        }
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
                HStack {
                    Text("offset(20, 20).fill()")
                    Spacer()
                    ZStack {
                        Circle()
                            .offset(x: 20.0, y: 20.0)
                            .fill()
                    }
                    .frame(width: 100.0, height: 100.0)
                    .border(.blue)
                }
            }.padding()
        }
    }
}
