// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct GesturePlayground: View {
    @State var tapPosition: CGPoint = .zero
    @State var doubleTapPosition: CGPoint = .zero
    @State var longPressCount = 0
    @State var dragOffset: CGSize = .zero
    @State var isTouchDown = false

    @State var combinedTapPosition: CGPoint = .zero
    @State var combinedDoubleTapPosition: CGPoint = .zero
    @State var combinedLongPressCount = 0
    @State var combinedDragOffset: CGSize = .zero

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
                                .onChanged { val in dragOffset = val.translation }
                                .onEnded { _ in withAnimation { dragOffset = .zero } }
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
                HStack {
                    VStack(alignment: .leading) {
                        Text("Tap: (\(Int(combinedTapPosition.x)), \(Int(combinedTapPosition.y)))")
                        Text("Double tap: (\(Int(combinedDoubleTapPosition.x)), \(Int(combinedDoubleTapPosition.y)))")
                        Text("Long press: \(combinedLongPressCount)")
                        Text("Drag")
                    }
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .offset(combinedDragOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { val in combinedDragOffset = val.translation }
                                .onEnded { _ in withAnimation { combinedDragOffset = .zero } }
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
                HStack {
                    Text("Disabled tap: (\(Int(tapPosition.x)), \(Int(tapPosition.y)))")
                    Spacer()
                    Color.red
                        .frame(width: 150, height: 150)
                        .onTapGesture {
                            tapPosition = $0
                        }
                        .disabled(true)
                }
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GesturePlayground.swift")
        }
    }
}
