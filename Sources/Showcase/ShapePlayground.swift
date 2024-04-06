// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ShapePlayground: View {
    @State var tapCount = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Capsule")
                    Spacer()
                    ZStack {
                        Capsule()
                            .fill()
                    }
                    .frame(width: 100, height: 50)
                    .border(.blue)
                }
                HStack {
                    Text("Capsule")
                    Spacer()
                    ZStack {
                        Capsule()
                            .fill()
                    }
                    .frame(width: 50, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("Circle")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("Circle")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill()
                    }
                    .frame(width: 100, height: 50)
                    .border(.blue)
                }
                HStack {
                    Text("Ellipse")
                    Spacer()
                    ZStack {
                        Ellipse()
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("Ellipse")
                    Spacer()
                    ZStack {
                        Ellipse()
                            .fill()
                    }
                    .frame(width: 100, height: 50)
                    .border(.blue)
                }
                HStack {
                    Text("Rectangle")
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("Rectangle")
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill()
                    }
                    .frame(width: 100, height: 50)
                    .border(.blue)
                }
                HStack {
                    Text("RoundedRectangle")
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("RoundedRectangle")
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerSize: CGSize(width: 40, height: 20))
                            .fill()
                    }
                    .frame(width: 100, height: 50)
                    .border(.blue)
                }
                HStack {
                    Text("UnevenRoundedRectangle")
                    Spacer()
                    ZStack {
                        UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: 20, bottomTrailingRadius: 30, topTrailingRadius: 40)
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                Text("Custom").font(.title).bold()
                HStack {
                    Text("Fill")
                    Spacer()
                    ZStack {
                        CustomShape()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("Stroke")
                    Spacer()
                    ZStack {
                        CustomShape()
                            .stroke(lineWidth: 10)
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("Rotation")
                    Spacer()
                    ZStack {
                        customPath(in: CGSize(width: 100, height: 100), transform: CGAffineTransform(rotationAngle: Angle(degrees: 30).radians))
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                Text("Fill & Stroke").font(.title).bold()
                HStack {
                    Text("fill(.red)")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(.red)
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("fill(.red.gradient)")
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(.red.gradient)
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("stroke()")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("stroke(.red, lineWidth: 10)")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(.red, lineWidth: 10)
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("stroke(.red.gradient, lineWidth: 10)")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(.red.gradient, style: StrokeStyle(lineWidth: 10))
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("stroke(.red,\n    style: StrokeStyle(\n    lineWidth: 10,\n      dash: [10]))")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(.red, style: StrokeStyle(lineWidth: 10, dash: [10.0]))
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("strokeBorder(.red, lineWidth: 10)")
                    Spacer()
                    ZStack {
                        Circle()
                            .strokeBorder(.red, lineWidth: 10)
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("fill(.red)\n  .stroke(.green, lineWidth: 10)")
                    Spacer()
                    ZStack {
                        if #available(iOS 17, macOS 14, *) {
                            Circle()
                                .fill(.red)
                                .stroke(.green, lineWidth: 10)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("stroke x2")
                    Spacer()
                    ZStack {
                        if #available(iOS 17, macOS 14, *) {
                            Circle()
                                .stroke(.red, lineWidth: 10)
                                .stroke(.green, lineWidth: 5)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                Text("Transforms").font(.title).bold()
                HStack {
                    Text("inset(by: 10)")
                    Spacer()
                    ZStack {
                        Rectangle()
                            .inset(by: 10)
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("offset(x: 30, y: 10)")
                    Spacer()
                    ZStack {
                        Rectangle()
                            .offset(x: 30, y: 10)
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("rotation(Angle(degrees: 45))")
                    Spacer()
                    ZStack {
                        Rectangle()
                            .rotation(Angle(degrees: -30))
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("scale(x: 0.5, y: 1.2)")
                    Spacer()
                    ZStack {
                        Rectangle()
                            .scale(x: 0.5, y: 1.2)
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("scale(x: 1, y: -1)")
                    Spacer()
                    ZStack {
                        UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: 20, bottomTrailingRadius: 30, topTrailingRadius: 40)
                            .scale(x: 1, y: -1)
                            .fill()
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                HStack {
                    Text("scale, rotate, offset, stroke")
                    Spacer()
                    ZStack {
                        Rectangle()
                            .scale(x: 0.5, y: 1.2)
                            .rotation(Angle(degrees: -30))
                            .offset(x: 30, y: 10)
                            .stroke(.red, lineWidth: 10)
                    }
                    .frame(width: 100, height: 100)
                    .border(.blue)
                }
                Text("Hit testing").font(.title).bold()
                HStack {
                    Text("Tap count: \(tapCount)")
                    Spacer()
                    ZStack {
                        customInsetPath()
                            .fill()
                            .onTapGesture { tapCount += 1 }
                    }
                    .frame(width: 200, height: 200)
                    .border(.blue)
                }
                HStack {
                    Text("Tap count: \(tapCount)")
                    Spacer()
                    ZStack {
                        customInsetPath()
                            .rotation(.degrees(45))
                            .stroke(.primary, lineWidth: 20)
                            .onTapGesture { tapCount += 1 }
                            .background(.yellow)
                    }
                    .frame(width: 200, height: 200)
                    .border(.blue)
                }
            }.padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ShapePlayground.swift")
        }
    }
}

struct CustomShape: Shape {
    let arcSize = 20.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + arcSize))
        path.addLine(to: CGPoint(x: rect.maxX - arcSize - arcSize * 2, y: rect.minY + arcSize))
        path.addRelativeArc(center: CGPoint(x: rect.maxX - arcSize - arcSize, y: rect.minY + arcSize), radius: arcSize, startAngle: Angle(degrees: -180), delta: Angle(degrees: 180))
        path.addArc(center: CGPoint(x: rect.maxX - arcSize, y: rect.minY + arcSize + arcSize), radius: arcSize, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        return path
    }
}

func customPath(in size: CGSize, transform: CGAffineTransform) -> Path {
    var path = Path()
    let rect = CGRect(origin: .zero, size: size).insetBy(dx: 20, dy: 0)
    path.addRect(rect, transform: transform)
    return path
}

func customInsetPath() -> Path {
    Path { p in
//        p.addRect(CGRect(x: 20, y: 20, width: 60, height: 60))
        p.move(to: CGPoint(x: 100, y: 50))
        p.addLine(to: CGPoint(x: 150, y: 150))
        p.addLine(to: CGPoint(x: 50, y: 150))
        p.closeSubpath()
    }
}
