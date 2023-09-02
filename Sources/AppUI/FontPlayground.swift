// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct FontPlayground: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Font")
                    .font(.title)
                Divider()

                Text("Plain")
                Text("Bold").bold()
                Text("Italic").italic()
                Text("Title bold italic").font(.title).bold().italic()
                VStack {
                    Text("Thin footnote container")
                    Text("Overridden to title font").font(.title)
                }
                .font(.footnote).fontWeight(.thin)
            }
            .padding()
        }
    }
}
