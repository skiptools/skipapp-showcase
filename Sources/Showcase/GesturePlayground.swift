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

    @State var combinedTapPosition: CGPoint = .zero
    @State var combinedDoubleTapPosition: CGPoint = .zero
    @State var combinedLongPressCount = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                HStack {
                    Text("Tap: (\(Int(tapPosition.x)), \(Int(tapPosition.y)))")
                    Spacer()
                    Color.red
                        .frame(width: 150.0, height: 150.0)
                        .onTapGesture {
                            tapPosition = $0
                        }
                }
                HStack {
                    Text("Double tap: (\(Int(doubleTapPosition.x)), \(Int(doubleTapPosition.y)))")
                    Spacer()
                    Color.red
                        .frame(width: 150.0, height: 150.0)
                        .onTapGesture(count: 2) {
                            doubleTapPosition = $0
                        }
                }
                HStack {
                    Text("Long press: \(longPressCount)")
                    Spacer()
                    Color.red
                        .frame(width: 150.0, height: 150.0)
                        .onLongPressGesture {
                            longPressCount += 1
                        }
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Tap: (\(Int(combinedTapPosition.x)), \(Int(combinedTapPosition.y)))")
                        Text("Double tap: (\(Int(combinedDoubleTapPosition.x)), \(Int(combinedDoubleTapPosition.y)))")
                        Text("Long press: \(combinedLongPressCount)")
                    }
                    Spacer()
                    Color.red
                        .frame(width: 150.0, height: 150.0)
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
                        .frame(width: 150.0, height: 150.0)
                        .onTapGesture {
                            tapPosition = $0
                        }
                        .disabled(true)
                }
            }
            .padding()
        }
    }
}
