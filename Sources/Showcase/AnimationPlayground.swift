// Copyright 2023–2026 Skip
import SwiftUI

// In Lite (transpiled) mode this playground uses Fuse-only API surfaces or
// Kotlin/Compose helpers that the transpiled SkipUI does not yet expose, so
// the original implementation is kept for Fuse only and Lite gets a stub.
#if SKIP_MODE_FUSE
struct AnimationPlayground: View {
    @State var isOn = false
    @State var unrelatedIsOn = false
    @State var isRepeatOn = false

    @State var blur = false
    @State var brightness = false
    @State var saturation = false
    @State var contrast = false
    @State var hue = false
    @State var grayscale = false
    @State var shadow = false
    @State var border = false
    @State var corner = false
    @State var combined = false
    @State var useAnimation = true

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Also see the `Transition` playground for view enter/exit animations")
                HStack {
                    Text(".opacity")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .opacity(isOn ? 0.2 : 1.0)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                HStack {
                    Text(".opacity.animation")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .opacity(isOn ? 0.2 : 1.0)
                        .animation(.default, value: isOn)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                HStack {
                    Text(".opacity.animation\n(different value)")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .opacity(isOn || unrelatedIsOn ? 0.2 : 1.0)
                        .animation(.default, value: isOn)
                        .onTapGesture {
                            unrelatedIsOn = !unrelatedIsOn
                        }
                }
                Button("withAnimation") {
                    withAnimation { isOn = !isOn }
                }
                .buttonStyle(.bordered)
                HStack {
                    Text(".foreground/.background")
                    Spacer()
                    Text("Text")
                        .font(.largeTitle)
                        .bold()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(isOn ? Color.white : Color.black)
                        .background(isOn ? Color.black : Color.white)
                        .border(Color.blue)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                HStack {
                    Text(".foreground/.background.animation")
                    Spacer()
                    Text("Text")
                        .font(.largeTitle)
                        .bold()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(isOn ? Color.white : Color.black)
                        .background(isOn ? Color.black : Color.white)
                        .border(Color.blue)
                        .animation(.default, value: isOn)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                Button("withAnimation") {
                    withAnimation { isOn = !isOn }
                }
                .buttonStyle(.bordered)
                HStack {
                    Text(".fill")
                    Spacer()
                    Circle()
                        .fill(isOn ? Color.blue : Color.red)
                        .frame(width: 100, height: 100)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                HStack {
                    Text(".fill.animation")
                    Spacer()
                    Circle()
                        .fill(isOn ? Color.blue : Color.red)
                        .frame(width: 100, height: 100)
                        .animation(.default, value: isOn)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                Button("withAnimation") {
                    withAnimation { isOn = !isOn }
                }
                .buttonStyle(.bordered)
                HStack {
                    Text(".offset")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isOn ? CGSize(width: 50, height: 10) : CGSize(width: 0, height: 0))
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                HStack {
                    Text(".offset.animation")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isOn ? CGSize(width: 50, height: 10) : CGSize(width: 0, height: 0))
                            .animation(.default, value: isOn)
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                Button("withAnimation") {
                    withAnimation { isOn = !isOn }
                }
                .buttonStyle(.bordered)
                HStack {
                    Text(".frame")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: isOn ? 100.0 : 40.0, height: isOn ? 60.0 : 40.0)
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                HStack {
                    Text(".frame.animation")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: isOn ? 100.0 : 40.0, height: isOn ? 60.0 : 40.0)
                            .animation(.default, value: isOn)
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                Button("withAnimation") {
                    withAnimation { isOn = !isOn }
                }
                .buttonStyle(.bordered)
                HStack {
                    Text(".rotationEffect")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .rotationEffect(isOn ? .degrees(45) : .degrees(0))
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                HStack {
                    Text(".rotationEffect.animation")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .rotationEffect(isOn ? .degrees(45) : .degrees(0))
                        .animation(.default, value: isOn)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                Button("withAnimation") {
                    withAnimation { isOn = !isOn }
                }
                .buttonStyle(.bordered)
                HStack {
                    Text(".scaleEffect")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .scaleEffect(isOn ? 0.5 : 1.0)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                HStack {
                    Text(".scaleEffect.animation")
                    Spacer()
                    Color.red
                        .frame(width: 100, height: 100)
                        .scaleEffect(isOn ? 0.5 : 1.0)
                        .animation(.default, value: isOn)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                Button("withAnimation") {
                    withAnimation { isOn = !isOn }
                }
                .buttonStyle(.bordered)
                HStack {
                    Text(".font")
                    Spacer()
                    Text("Hello")
                        .font(.system(size: isOn ? 30.0 : 20.0))
                        .frame(width: 100, height: 100)
                        .border(Color.blue)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                HStack {
                    Text(".font.animation")
                    Spacer()
                    Text("Hello")
                        .font(.system(size: isOn ? 30.0 : 20.0))
                        .frame(width: 100, height: 100)
                        .border(Color.blue)
                        .animation(.default, value: isOn)
                        .onTapGesture {
                            isOn = !isOn
                        }
                }
                Button("withAnimation") {
                    withAnimation { isOn = !isOn }
                }
                .buttonStyle(.bordered)
                HStack {
                    Text(".animation(.spring)")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isOn ? CGSize(width: 0, height: 50) : CGSize(width: 0, height: -50))
                            .animation(.spring, value: isOn)
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                HStack {
                    Text("withAnimation(.spring)")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isOn ? CGSize(width: 0, height: 50) : CGSize(width: 0, height: -50))
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        withAnimation(.spring) { isOn = !isOn }
                    }
                }
                HStack {
                    Text(".animation(.easeIn(duration: 1))")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isOn ? CGSize(width: 0, height: 50) : CGSize(width: 0, height: -50))
                            .animation(.easeIn(duration: 1), value: isOn)
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                HStack {
                    Text("withAnimation(.easeIn(duration: 1))")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isOn ? CGSize(width: 0, height: 50) : CGSize(width: 0, height: -50))
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 1)) { isOn = !isOn }
                    }
                }
                HStack {
                    Text(".animation(repeatCount(3))")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isOn ? CGSize(width: 0, height: 50) : CGSize(width: 0, height: -50))
                            .animation(.default.repeatCount(3), value: isOn)
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                HStack {
                    Text("withAnimation(repeatCount(3))")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isOn ? CGSize(width: 0, height: 50) : CGSize(width: 0, height: -50))
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        withAnimation(.default.repeatCount(3)) { isOn = !isOn }
                    }
                }
                HStack {
                    Text(".animation(autoreverses: false))")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isOn ? CGSize(width: 0, height: 50) : CGSize(width: 0, height: -50))
                            .animation(.default.repeatCount(3, autoreverses: false), value: isOn)
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                HStack {
                    Text(".repeatForever()")
                    Spacer()
                    ZStack {
                        Color.red
                            .frame(width: 20, height: 20)
                            .offset(isRepeatOn ? CGSize(width: 0, height: 50) : CGSize(width: 0, height: -50))
                            .animation(.default.repeatForever(), value: isRepeatOn)
                    }
                    .frame(width: 100, height: 100)
                    .background(.gray)
                    .onAppear {
                        isRepeatOn = true
                    }
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                HStack {
                    Text(".trim")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 12)
                        Circle()
                            .trim(from: 0, to: isOn ? 1.0 : 0.0)
                            .stroke(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 12, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                        Text("\(Int((isOn ? 1.0 : 0.0) * 100))%")
                            .font(.title)
                            .bold()
                    }
                    .frame(width: 120, height: 120)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                HStack {
                    Text(".trim.animation")
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 12)
                        Circle()
                            .trim(from: 0, to: isOn ? 1.0 : 0.0)
                            .stroke(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                style: StrokeStyle(lineWidth: 12, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut(duration: 1.5), value: isOn)
                        Text("\(Int((isOn ? 1.0 : 0.0) * 100))%")
                            .font(.title)
                            .bold()
                    }
                    .frame(width: 120, height: 120)
                    .onTapGesture {
                        isOn = !isOn
                    }
                }
                Button("withAnimation") {
                    withAnimation(.easeInOut(duration: 1.5)) { isOn = !isOn }
                }
                .buttonStyle(.bordered)
                NavigationLink("Push") {
                    Text("Pushed")
                }
                .buttonStyle(.bordered)

                Divider()
                    .padding(.vertical, 8)

                Text("Tap each item to animate")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Toggle("Use Animation", isOn: $useAnimation)
                    .padding(.vertical, 4)

                Button(action: {
                    performAnimation {
                        blur.toggle()
                        brightness.toggle()
                        saturation.toggle()
                        contrast.toggle()
                        hue.toggle()
                        grayscale.toggle()
                        shadow.toggle()
                        border.toggle()
                        corner.toggle()
                        combined.toggle()
                    }
                }) {
                    Text("Animate All")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom, 4)

                // cannot use LazyVGrid in Scrollview, else
                /*
                let columns = [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ]

                LazyVGrid(columns: columns, spacing: 12) {
                */    

                HStack(spacing: 12) {
                    animationCell(label: ".blur") {
                        gradientRect()
                            .blur(radius: blur ? 10 : 0)
                    } action: { blur.toggle() }

                    animationCell(label: ".brightness") {
                        gradientRect()
                            .brightness(brightness ? 0.3 : 0)
                    } action: { brightness.toggle() }

                    animationCell(label: ".saturation") {
                        gradientRect()
                            .saturation(saturation ? 0.2 : 1.0)
                    } action: { saturation.toggle() }
                }

                HStack(spacing: 12) {
                    animationCell(label: ".contrast") {
                        gradientRect()
                            .contrast(contrast ? 2.0 : 1.0)
                    } action: { contrast.toggle() }

                    animationCell(label: ".hueRotation") {
                        gradientRect()
                            .hueRotation(.degrees(hue ? 180 : 0))
                    } action: { hue.toggle() }

                    animationCell(label: ".grayscale") {
                        gradientRect()
                            .grayscale(grayscale ? 1.0 : 0)
                    } action: { grayscale.toggle() }
                }

                HStack(spacing: 12) {
                    animationCell(label: ".border") {
                        gradientRect()
                            .border(Color.blue, width: border ? 8 : 1)
                    } action: { border.toggle() }

                    animationCell(label: ".cornerRadius") {
                        gradientRect()
                            .cornerRadius(corner ? 35 : 0)
                    } action: { corner.toggle() }

                    animationCell(label: "Combined") {
                        gradientRect()
                            .blur(radius: combined ? 10 : 0)
                            .brightness(combined ? 0.3 : 0)
                            .saturation(combined ? 0.2 : 1.0)
                            .contrast(combined ? 2.0 : 1.0)
                            .hueRotation(.degrees(combined ? 180 : 0))
                            .grayscale(combined ? 1.0 : 0)
                            .border(Color.white, width: combined ? 8 : 1)
                            .cornerRadius(combined ? 35 : 8)
                    } action: { combined.toggle() }
                }

                Divider()
                    .padding(.vertical, 4)

                // Shadow Test (NOT animated - crashes when animated)
                HStack {
                    Text(".shadow(...) - NOT animated").font(.caption)
                    Spacer()
                    Rectangle()
                        .fill(LinearGradient(colors: [.blue, .purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 70, height: 70)
                        .shadow(color: .black.opacity(0.5), radius: shadow ? 15 : 0, x: shadow ? 10 : 0, y: shadow ? 10 : 0)
                        .padding(20)
                        .onTapGesture {
                            performAnimation {
                                shadow.toggle()
                            }
                        }
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "AnimationPlayground.swift")
        }
    }

    private func gradientRect() -> some View {
        Rectangle()
            .fill(LinearGradient(colors: [.blue, .purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
            .aspectRatio(1, contentMode: .fit)
    }

    private func animationCell<V: View>(label: String, @ViewBuilder content: () -> V, action: @escaping () -> Void) -> some View {
        VStack(spacing: 4) {
            content()
                .clipShape(Rectangle())
            Text(label)
                .font(.system(size: 10))
                .lineLimit(1)
                .foregroundStyle(.secondary)
        }
        .onTapGesture {
            performAnimation {
                action()
            }
        }
    }

    private func performAnimation(_ action: @escaping () -> Void) {
        if useAnimation {
            withAnimation(.spring(duration: 1.0)) {
                action()
            }
        } else {
            action()
        }
    }
}
#else
struct AnimationPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("AnimationPlayground uses SwiftUI animation curves with mixed Int/Double literals that the Lite transpiler can't auto-convert.")
                .multilineTextAlignment(.center)
                .padding()
            Text("Run the app with SKIP_MODE=fuse to see this playground.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "AnimationPlayground.swift")
        }
    }
}
#endif
