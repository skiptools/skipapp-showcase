// Copyright 2023–2025 Skip
import SwiftUI

struct StatePlayground: View {
    @State var tapCount = 0
    @State var hasStateTapped: Bool? // Test optional vars
    @State var tapCountObservable: TapCountObservable
    @State var tapCountStruct: TapCountStruct
    @State var tapCountRepository = TapCountRepository() // Test ForEach observable

    init() {
        // Test that we can initialze state property wrappers
        _tapCountObservable = State(initialValue: TapCountObservable())
        _tapCountStruct = State(wrappedValue: TapCountStruct())
    }

    var body: some View {
        List {
            Section {
                NavigationLink("Push another", value: PlaygroundType.state)
                NavigationLink("Push binding view") {
                    StatePlaygroundDestinationBindingView(tapCount: $tapCount)
                }
            }
            Section {
                if hasStateTapped == true {
                    Text("State tap count: \(tapCount)")
                } else {
                    Text("Tap below to increment state tap count")
                }
                Button("State") {
                    tapCount += 1
                    hasStateTapped = true
                }
                StatePlaygroundBindingView(tapCount: $tapCount)
            }
            Section {
                Text("Observable tap count: \(tapCountObservable.tapCount)")
                Button("Observable") {
                    tapCountObservable.tapCount += 1
                }
                StatePlaygroundBindingView(tapCount: $tapCountObservable.tapCount)
            }
            Section {
                Text("Struct tap count: \(tapCountStruct.tapCount)")
                Button("Struct") {
                    tapCountStruct.tapCount += 1
                }
                StatePlaygroundStructBindingView(tapCountStruct: $tapCountStruct)
            }
            Section {
                Text("Struct tap count (field): \(tapCountStruct.tapCount)")
                Button("Struct (field)") {
                    tapCountStruct.tapCount += 1
                }
                StatePlaygroundBindingView(tapCount: $tapCountStruct.tapCount)
            }
            Section {
                ForEach(tapCountRepository.items) { item in
                    Text("Repository item tap count: \(item.tapCount)")
                }
                Button("Add item") { tapCountRepository.add() }
                Button("Increment last") { tapCountRepository.increment() }
            }
            Section {
                NavigationLink("ForEach state") {
                    StatePlaygroundForEachView()
                }
            }
        }
        .onChange(of: tapCount) { oldValue, newValue in
            logger.log("onChange(of: tapCount): \(newValue)")
        }
        .onChange(of: tapCountObservable.tapCount) { oldValue, newValue in
            logger.log("onChange(of: tapCountObservable.tapCount): \(newValue)")
        }
        .onChange(of: tapCountStruct.tapCount) { oldValue, newValue in
            logger.log("onChange(of: tapCountStruct.tapCount): \(newValue)")
        }
        .toolbar {
            PlaygroundSourceLink(file: "StatePlayground.swift")
        }
    }
}

struct StatePlaygroundBindingView: View {
    @Binding var tapCount: Int
    var body: some View {
        Button("Binding") {
            tapCount += 1
        }
    }
}

struct StatePlaygroundStructBindingView: View {
    @Binding var tapCountStruct: TapCountStruct
    var body: some View {
        Button("Binding") {
            tapCountStruct.tapCount += 1
        }
    }
}

struct StatePlaygroundDestinationBindingView: View {
    @Binding var tapCount: Int

    var body: some View {
        VStack {
            SubView1(tapCount: _tapCount)
            SubView2(tapCount: _tapCount)
        }
        .navigationTitle("Binding View")
    }

    struct SubView1: View {
        @Binding var tapCount: Int

        var body: some View {
            Button("Bound tap count 1: \(tapCount)") {
                tapCount += 1
            }
            .buttonStyle(.bordered)
        }
    }

    struct SubView2: View {
        @Binding var tapCount: Int

        var body: some View {
            Button("Bound tap count 2: \(tapCount)") {
                tapCount += 1
            }
            .buttonStyle(.bordered)
        }
    }
}

struct StatePlaygroundForEachView: View {
    @State var tapCount = 0

    var body: some View {
        VStack {
            ForEach(0..<1) { i in
                Text("ForEach taps: \(tapCount)")
                    .onTapGesture {
                        tapCount += 1
                    }
            }
        }
    }
}
