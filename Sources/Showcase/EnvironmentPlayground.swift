// Copyright 2023–2025 Skip
import SwiftUI

struct EnvironmentPlayground: View {
    @State var tapCountObservable = TapCountObservable()

    var body: some View {
        List {
            Section {
                EnvironmentPlaygroundEnvironmentObjectView()
                    .environment(tapCountObservable)
            }
            Section {
                EnvironmentPlaygroundCustomKeyView(label: "Custom key default")
                EnvironmentPlaygroundCustomKeyView(label: "Custom key value")
                    .environment(\.environmentPlaygroundCustomKey, "Custom!")
            }
        }
        .onChange(of: tapCountObservable.tapCount) {
            logger.log("onChange(of: tapCountObservable.tapCount): \($0)")
        }
        .toolbar {
            PlaygroundSourceLink(file: "EnvironmentPlayground.swift")
        }
    }
}

struct EnvironmentPlaygroundCustomKey: EnvironmentKey {
    static let defaultValue = "default"
}

extension EnvironmentValues {
    var environmentPlaygroundCustomKey: String {
        get { self[EnvironmentPlaygroundCustomKey.self] }
        set { self[EnvironmentPlaygroundCustomKey.self] = newValue }
    }
}

struct EnvironmentPlaygroundEnvironmentObjectView: View {
    @Environment(TapCountObservable.self) var tapCountObservable

    var body: some View {
        Text("EnvironmentObject tap count: \(tapCountObservable.tapCount)")
        Button("EnvironmentObject") {
            tapCountObservable.tapCount += 1
        }
        @Bindable var tco = tapCountObservable
        StatePlaygroundBindingView(tapCount: $tco.tapCount)
    }
}

struct EnvironmentPlaygroundCustomKeyView : View {
    let label: String
    @Environment(\.environmentPlaygroundCustomKey) var customKeyValue

    var body: some View {
        HStack {
            Text(verbatim: label)
            Spacer()
            Text(verbatim: customKeyValue)
                .foregroundStyle(.secondary)
        }
    }
}
