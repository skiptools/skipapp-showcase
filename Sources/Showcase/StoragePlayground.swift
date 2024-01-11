// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct StoragePlayground: View {
    @AppStorage("boolAppStorage") var boolAppStorage = false
    @AppStorage("enumAppStorage") var enumAppStorage = E.first

    enum E: Int {
        case first, second, third
    }

    var body: some View {
        VStack(spacing: 16.0) {
            HStack {
                Text("Enum AppStorage")
                Spacer()
                Picker("Enum AppStorage", selection: $enumAppStorage) {
                    Text("First").tag(E.first)
                    Text("Second").tag(E.second)
                    Text("Third").tag(E.third)
                }
            }
            Toggle("Bool AppStorage", isOn: $boolAppStorage)
            NavigationLink("Push binding") {
                StoragePlaygroundBindingView(binding: $boolAppStorage)
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
