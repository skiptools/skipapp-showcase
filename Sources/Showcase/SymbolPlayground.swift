// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct SymbolPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                symbolRow("person.crop.square")
                symbolRow("person.crop.circle")
                symbolRow("plus.circle.fill")
                symbolRow("plus")
                symbolRow("arrow.left")
                symbolRow("arrowtriangle.down.fill")
                symbolRow("arrow.forward")
                symbolRow("wrench")
                symbolRow("phone")
                symbolRow("checkmark.circle")
                symbolRow("checkmark")
                symbolRow("xmark")
                symbolRow("pencil")
                symbolRow("calendar")
                symbolRow("trash")
                symbolRow("envelope")
                symbolRow("arrow.forward.square")
                symbolRow("face.smiling")
                symbolRow("heart")
                symbolRow("heart.fill")
                symbolRow("house")
                symbolRow("info.circle")
                symbolRow("chevron.down")
                symbolRow("chevron.left")
                symbolRow("chevron.right")
                symbolRow("chevron.up")
                symbolRow("list.bullet")
                symbolRow("location")
                symbolRow("lock")
                symbolRow("line.3.horizontal")
                symbolRow("ellipsis")
                symbolRow("bell")
                symbolRow("person")
                symbolRow("mappin.circle")
                symbolRow("play")
                symbolRow("arrow.clockwise.circle")
                symbolRow("magnifyingglass")
                symbolRow("paperplane")
                symbolRow("gearshape")
                symbolRow("square.and.arrow.up")
                symbolRow("cart")
                symbolRow("star")
                symbolRow("hand.thumbsup")
                symbolRow("exclamationmark.triangle")
                symbolRow("person.crop.square.fill")
                symbolRow("person.crop.circle.fill")
                symbolRow("wrench.fill")
                symbolRow("phone.fill")
                symbolRow("checkmark.circle.fill")
                symbolRow("trash.fill")
                symbolRow("envelope.fill")
                symbolRow("house.fill")
                symbolRow("info.circle.fill")
                symbolRow("location.fill")
                symbolRow("lock.fill")
                symbolRow("bell.fill")
                symbolRow("person.fill")
                symbolRow("mappin.circle.fill")
                symbolRow("play.fill")
                symbolRow("paperplane.fill")
                symbolRow("gearshape.fill")
                symbolRow("square.and.arrow.up.fill")
                symbolRow("cart.fill")
                symbolRow("star.fill")
                symbolRow("hand.thumbsup.fill")
                symbolRow("exclamationmark.triangle.fill")
                HStack {
                    Text(".foregroundStyle(.red)")
                    Spacer()
                    Image(systemName: "star.fill")
                        .foregroundStyle(.red)
                }
                HStack {
                    Text(".tint(.red)")
                    Spacer()
                    Image(systemName: "star.fill")
                        .tint(.red)
                }
                HStack {
                    Text(".font(.title)")
                    Spacer()
                    Image(systemName: "star.fill")
                        .font(.title)
                }
            }
        }
        .padding()
    }

    func symbolRow(_ systemName: String) -> some View {
        HStack {
            Text(systemName)
            Spacer()
            Image(systemName: systemName)
        }
    }
}
