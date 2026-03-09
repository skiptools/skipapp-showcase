// Copyright 2023–2025 Skip
import SwiftUI

struct ScenePhasePlayground: View {
    @Environment(\.scenePhase) var scenePhase
    @State var history: [ScenePhase] = []

    var body: some View {
        List {
            Section("ScenePhase history") {
                ForEach(Array(history.enumerated()), id: \.offset) { phase in
                    Text(verbatim: String(describing: phase.element))
                }
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            logger.log("onChange(of: schenePhase): \(String(describing: newPhase))")
            history.append(newPhase)

        }
        .toolbar {
            PlaygroundSourceLink(file: "ScenePhasePlayground.swift")
        }
    }
}
