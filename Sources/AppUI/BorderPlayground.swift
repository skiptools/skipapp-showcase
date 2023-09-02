// Copyright 20222 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct BorderPlayground: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Border")
                    .font(.title)
                Divider()
                Color.red
                    .frame(width: 100.0, height: 100.0)
                    .border(Color.black)
                Color.red
                    .frame(width: 100.0, height: 100.0)
                    .padding()
                    .border(Color.black)
                Color.red
                    .frame(width: 100.0, height: 100.0)
                    .padding([.top, .leading], 32.0)
                    .border(Color.black)
                Color.red
                    .frame(width: 100.0, height: 100.0)
                    .border(Color.blue, width: 5.0)
            }
            .padding()
        }
    }
}
