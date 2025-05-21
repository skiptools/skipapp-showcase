import SwiftUI

// TODO tedious double-definition of PreferenceKey
struct TestPreferenceKey: PreferenceKey {
    typealias Value = String
    
    #if SKIP
    // SKIP DECLARE: companion object: PreferenceKeyCompanion<String>
    final class Companion: PreferenceKeyCompanion {
        let defaultValue = ""
        func reduce(value: inout String, nextValue: () -> String) {
            value = nextValue()
        }
    }
    #else
    static var defaultValue: String = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
    #endif
}

struct ChildView: View {
    @State private var preferenceValueToSet: String = "Initial Value from Child"

    var body: some View {
        VStack {
            Text("Child View")
            Button("Change Preference to 'Hello World'") {
                preferenceValueToSet = "Hello World from Child"
            }
            Button("Change Preference to 'Goodbye'") {
                preferenceValueToSet = "Goodbye from Child"
            }
        }
        .preference(key: TestPreferenceKey.self, value: preferenceValueToSet)
    }
}

struct PreferencePlayground: View {
    @State private var receivedPreferenceValue: String = "(No preference received yet)"

    var body: some View {
        VStack {
            Text("Parent View")
            Text("Received from child: \(receivedPreferenceValue)")
                .padding()
            
            ChildView()
        }
        .onPreferenceChange(TestPreferenceKey.self) { newValue in
            print("Preference changed to: \(newValue)")
            self.receivedPreferenceValue = newValue
        }
        .toolbar {
            PlaygroundSourceLink(file: "PreferencePlayground.swift")
        }
    }
}
