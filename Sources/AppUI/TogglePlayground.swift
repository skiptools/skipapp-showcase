// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct TogglePlayground: View {
    @State var isOn = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                Text("Toggle")
                    .font(.title)
                Divider()

                Toggle(isOn: $isOn) {
                    Text("Viewbuilder init")
                }
                Toggle("String init", isOn: $isOn)
                Toggle("Fixed width", isOn: $isOn)
                    .frame(width: 200.0)
                VStack {
                    Text(".labelsHidden():")
                    Toggle("Label", isOn: $isOn)
                }
                .labelsHidden()
            }
            .padding()
        }
    }
}
