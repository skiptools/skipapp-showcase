// Copyright 2023–2025 Skip
import SwiftUI

struct GesturePlayground: View {
    @State var tapPosition: CGPoint = .zero
    @State var doubleTapPosition: CGPoint = .zero
    @State var longPressCount = 0
    @State var dragOffset: CGSize = .zero
    @State var globalDragOffset: CGSize = .zero
    @State var magnification: CGFloat = 1.0
    @State var rotation: Angle = .degrees(0.0)
    @State var isTouchDown = false

    @State var combinedTapPosition: CGPoint = .zero
    @State var combinedDoubleTapPosition: CGPoint = .zero
    @State var combinedLongPressCount = 0
    @State var combinedDragOffset: CGSize = .zero
    @State var combinedMagnification: CGFloat = 1.0

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("onTapGesture: (\(Int(tapPosition.x)), \(Int(tapPosition.y)))")
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .onTapGesture {
                            tapPosition = $0
                        }
                }
                HStack {
                    Text("TapGesture: (\(Int(tapPosition.x)), \(Int(tapPosition.y)))")
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .gesture(
                            TapGesture()
                                .onEnded { _ in tapPosition = CGPoint(x: -1, y: -1) }
                        )
                }
                HStack {
                    Text(".onTapGesture(2): (\(Int(doubleTapPosition.x)), \(Int(doubleTapPosition.y)))")
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .onTapGesture(count: 2) {
                            doubleTapPosition = $0
                        }
                }
                HStack {
                    Text("Tap(2): (\(Int(doubleTapPosition.x)), \(Int(doubleTapPosition.y)))")
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .gesture(
                            TapGesture(count: 2)
                                .onEnded { _ in doubleTapPosition = CGPoint(x: -1, y: -1) }
                        )
                }
                HStack {
                    Text(".onLongPressGesture: \(longPressCount)")
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .onLongPressGesture {
                            longPressCount += 1
                        } onPressingChanged: { val in
                            logger.log("LongPress onChanged: \(val)")
                        }
                }
                HStack {
                    Text("LongPress: \(longPressCount)")
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .gesture(
                            LongPressGesture()
                                .onChanged { val in logger.log("LongPress onChanged: \(val)") }
                                .onEnded { _ in longPressCount += 1 }
                        )
                }
                HStack {
                    Text("Drag")
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .offset(dragOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { val in
                                    dragOffset = val.translation
                                    logger.info("Drag position: (\(val.location.x), \(val.location.y))")
                                }
                                .onEnded { _ in withAnimation { dragOffset = .zero } }
                        )
                }
                HStack {
                    Text("Global Drag")
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .offset(globalDragOffset)
                        .gesture(
                            DragGesture(coordinateSpace: .global)
                                .onChanged { val in
                                    globalDragOffset = val.translation
                                    logger.info("Drag position: (\(val.location.x), \(val.location.y))")
                                }
                                .onEnded { _ in withAnimation { globalDragOffset = .zero } }
                        )
                }
                HStack {
                    Text("Touch")
                    Spacer()
                    Rectangle()
                        .fill(isTouchDown ? Color.green : Color.red)
                        .frame(width: 150, height: 150)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in isTouchDown = true }
                                .onEnded { _ in isTouchDown = false }
                        )
                }
                VStack {
                    Text("Magnify")
                    Color.red
                        .frame(width: 150, height: 150)
                        .scaleEffect(magnification)
                        .gesture(
                            MagnifyGesture()
                                .onChanged { val in
                                    magnification = val.magnification
                                }
                                .onEnded { _ in withAnimation { magnification = 1.0 } }
                        )
                }
                VStack {
                    Text("Rotate")
                    Color.red
                        .frame(width: 150, height: 150)
                        .rotationEffect(rotation)
                        .gesture(
                            RotateGesture()
                                .onChanged { val in
                                    rotation = val.rotation
                                }
                                .onEnded { _ in withAnimation { rotation = .degrees(0.0) } }
                        )
                }
                VStack {
                    VStack {
                        Text("Tap: (\(Int(combinedTapPosition.x)), \(Int(combinedTapPosition.y)))")
                        Text("Double tap: (\(Int(combinedDoubleTapPosition.x)), \(Int(combinedDoubleTapPosition.y)))")
                        Text("Long press: \(combinedLongPressCount)")
                        Text("Drag, Magnify")
                    }
                    Color.red
                        .frame(width: 150, height: 150)
                        .offset(combinedDragOffset)
                        .scaleEffect(combinedMagnification)
                        .gesture(
                            DragGesture()
                                .onChanged { val in combinedDragOffset = val.translation }
                                .onEnded { _ in withAnimation { combinedDragOffset = .zero } }
                        )
                        .gesture(
                            MagnifyGesture()
                                .onChanged { val in
                                    combinedMagnification = val.magnification
                                }
                                .onEnded { _ in withAnimation { combinedMagnification = 1.0 } }
                        )
                        .onTapGesture(count: 2) {
                            combinedDoubleTapPosition = $0
                        }
                        .onTapGesture {
                            combinedTapPosition = $0
                        }
                        .onLongPressGesture {
                            combinedLongPressCount += 1
                        }
                }
                Spacer(minLength: 300)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GesturePlayground.swift")
        }
    }
}
