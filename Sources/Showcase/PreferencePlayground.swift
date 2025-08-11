// Copyright 2023–2025 Skip
import SwiftUI

struct PreferencePlayground: View {
    @State var preferenceValue = 0

    var body: some View {
        VStack {
            PreferencePlaygroundCustomKeyDisplayView(incrementing: false)
            Divider()
            PreferencePlaygroundCustomKeyDisplayView(incrementing: true)
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "PreferencePlayground.swift")
        }
    }
}

struct PreferencePlaygroundCustomKey: PreferenceKey {
    static let defaultValue = 100
    static func reduce(value: inout Int, nextValue: () -> Int) {
        value = nextValue()
    }
}

struct PreferencePlaygroundCustomKeyDisplayView: View {
    let incrementing: Bool
    @State var value = 0

    var body: some View {
        VStack {
            Text("Preference value: \(value)")
            if incrementing {
                PreferencePlaygroundCustomKeyIncrementView()
            }
        }
        .onPreferenceChange(PreferencePlaygroundCustomKey.self) {
            logger.info("Preference changed: \($0)")
            value = $0
        }
    }
}

struct PreferencePlaygroundCustomKeyIncrementView : View {
    @State var count = 0

    var body: some View {
        Button("Increment") {
            count += 1
        }
        .preference(key: PreferencePlaygroundCustomKey.self, value: count)
    }
}
