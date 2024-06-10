// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ScenePhasePlayground: View {
    @Environment(\.scenePhase) var scenePhase
    @State var history: [Any] = [] //~~~

    var body: some View {
        List {
            Section("ScenePhase history") {
                ForEach(Array(history.enumerated()), id: \.offset) { phase in
                    Text(verbatim: String(describing: phase.element))
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            logger.log("onChange(of: schenePhase): \(String(describing: phase))")
            history.append(phase)

        }
        .toolbar {
            PlaygroundSourceLink(file: "ScenePhasePlayground.swift")
        }
    }
}
