// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct LabelPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Label {
                    Text("Label & Icon")
                } icon: {
                    Image(systemName: "star.fill")
                }
                Label("Title & SystemImage", systemImage: "star.fill")
                Label(".font(.title)", systemImage: "star.fill")
                    .font(.title)
                Label(".foregroundStyle(Color.red)", systemImage: "star.fill")
                    .foregroundStyle(Color.red)
                Label(".tint(.red)", systemImage: "star.fill")
                    .tint(.red)
            }
            .padding()
        }
    }
}

