// Copyright 2023–2025 Skip
import SwiftUI

struct GraphicsPlayground: View {
    @State var isRotating3D = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Standard")
                    Spacer()
                    ZStack {
                        Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Hello")
                            .font(.title).bold()
                            .foregroundStyle(Color.red)
                    }
                    .frame(width: 200, height: 200)
                }
                HStack {
                    Text(".grayscale(0.99)")
                    Spacer()
                    ZStack {
                        Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Hello")
                            .font(.title).bold()
                            .foregroundStyle(Color.red)
                    }
                    .frame(width: 200, height: 200)
                    .grayscale(0.99)
                }
                HStack {
                    Text(".grayscale(0.25)")
                    Spacer()
                    ZStack {
                        Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Hello")
                            .font(.title).bold()
                            .foregroundStyle(Color.red)
                    }
                    .frame(width: 200, height: 200)
                    .grayscale(0.25)
                }
                HStack {
                    Text(".colorInvert()")
                    Spacer()
                    Image("skiplogo", bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .colorInvert()
                        .frame(width: 50, height: 50)
                    Image("Cat", bundle: .module)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.red)
                        .colorInvert()
                        .frame(width: 100, height: 100)
                    Text("123")
                        .foregroundStyle(Color.red)
                        .colorInvert()
                }
                Text(".rotation3DEffects")
                Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .rotation3DEffect(.degrees(isRotating3D ? 0.0 : 360.0), axis: (x: 0, y: 1, z: 0))
                    .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: isRotating3D)
                    .onAppear { isRotating3D = true }
                Image("Cat", bundle: .module, label: Text("Cat JPEG image"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400, height: 400)
                    .rotation3DEffect(.degrees(45.0), axis: (x: 1.0, y: 0.0, z: 0.0))
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GraphicsPlayground.swift")
        }
    }
}
