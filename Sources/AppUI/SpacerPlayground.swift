// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct SpacerPlayground: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Spacer")
                    .font(.title)
                Divider()
                HStack {
                    Text("First")
                    Spacer()
                    Text("Last")
                }
                HStack {
                    Text("First")
                    Spacer()
                        .frame(width: 100.0)
                    Text("Last")
                }
            }
            .padding()
        }
    }
}

