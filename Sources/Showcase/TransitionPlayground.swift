// Copyright 2023–2025 Skip
import SwiftUI

struct TransitionPlayground: View {
    @State var count = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Default")
                    Spacer()
                    ZStack {
                        if count % 2 == 1 {
                            Color.red
                                .frame(width: 20, height: 20)
                                .id(1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text(".animation")
                    Spacer()
                    ZStack {
                        if count % 2 == 1 {
                            Color.red
                                .frame(width: 20, height: 20)
                                .id(1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                Button("withAnimation") {
                    withAnimation { updateCount() }
                }
                .buttonStyle(.bordered)
                HStack {
                    Text("HStack.animation")
                    Spacer()
                    HStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text("VStack.animation")
                    Spacer()
                    VStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text("ZStack.animation")
                    Spacer()
                    ZStack {
                        if count > 0 {
                            Color.red
                                .frame(width: 60, height: 60)
                                .id(1)
                        }
                        if count > 1 {
                            Color.green
                                .frame(width: 40, height: 40)
                                .id(2)
                        }
                        if count > 2 {
                            Color.blue
                                .frame(width: 20, height: 20)
                                .id(3)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text(".transition(.move(edge: .top))")
                    Spacer()
                    HStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .transition(.move(edge: .top))
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text(".transition(.offset)")
                    Spacer()
                    VStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .transition(.offset(x: 100, y: 100))
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text(".transition(.opacity)")
                    Spacer()
                    VStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .transition(.opacity)
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text(".transition(.push(from: .top))")
                    Spacer()
                    HStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .transition(.push(from: .top))
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text(".transition(.scale)")
                    Spacer()
                    VStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .transition(.scale)
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text(".transition(.slide)")
                    Spacer()
                    VStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .transition(.slide)
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text("Asymmetric: opacity+slide")
                    Spacer()
                    VStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .transition(.asymmetric(insertion: .opacity, removal: .slide))
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text("Combined: opacity+slide")
                    Spacer()
                    VStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .transition(.opacity.combined(with: .slide))
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text("Slow spring")
                    Spacer()
                    VStack {
                        ForEach(0..<count, id: \.self) { i in
                            Color.red
                                .frame(width: 20, height: 20)
                                .transition(.slide)
                                .id(i + 1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.spring(duration: 1), value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                HStack {
                    Text("Nested views")
                    Spacer()
                    ZStack {
                        if count % 2 == 1 {
                            VStack {
                                Color.red
                                    .frame(width: 20, height: 20)
                                    .transition(.slide)
                                    .id(1)
                                if count % 2 == 1 {
                                    Color.green
                                        .frame(width: 20, height: 20)
                                        .transition(.slide)
                                        .id(2)
                                }
                            }
                            .frame(width: 80, height: 80)
                            .background(.white)
                            .transition(.opacity)
                            .id(1)
                        }
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .animation(.default, value: count)
                    .onTapGesture {
                        updateCount()
                    }
                }
                Button("withAnimation") {
                    withAnimation { updateCount() }
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "TransitionPlayground.swift")
        }
    }

    private func updateCount() {
        count += 1
        if count > 3 {
            count = 0
        }
    }
}
