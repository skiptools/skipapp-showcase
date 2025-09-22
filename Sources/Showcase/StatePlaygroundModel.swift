// Copyright 2023–2025 Skip
import Observation
#if canImport(SkipFuse) && !SKIP
import SkipFuse
#endif

// Test that observables in a different file work

@Observable
class TapCountObservable {
    var tapCount = 0
}

struct TapCountStruct : Identifiable {
    var id = 0
    var tapCount = 0
}

@Observable
class TapCountRepository {
    var items: [TapCountStruct] = []

    func add() {
        items.append(TapCountStruct(id: items.count))
    }

    func increment() {
        if !items.isEmpty {
            items[items.count - 1].tapCount += 1
        }
    }
}
