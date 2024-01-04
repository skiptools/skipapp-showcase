// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct StoragePlayground: View {
    @AppStorage("appstorage") var appstorage = false

    var body: some View {
        VStack(spacing: 16.0) {
            Toggle("AppStorage", isOn: $appstorage)
            NavigationLink("Push binding") {
                StoragePlaygroundBindingView(binding: $appstorage)
            }
            NavigationLink("Push another", value: PlaygroundType.storage)
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "StoragePlayground.swift")
        }
    }
}

struct StoragePlaygroundBindingView: View {
    @Binding var binding: Bool

    var body: some View {
        Toggle("Storage", isOn: $binding)
            .padding()
            .navigationTitle("Storage Binding")
    }
}
