// Copyright 2023–2025 Skip
import SwiftUI
#if SKIP
import androidx.compose.foundation.layout.size
import androidx.compose.ui.unit.dp
#endif

struct ProgressViewPlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    Text("Indeterminate")
                    Spacer()
                    ProgressView()
                }
                HStack {
                    Text("Progress nil")
                    Spacer()
                    ProgressView(value: nil, total: 1)
                }
                HStack {
                    Text("Progress 0.5")
                    Spacer()
                    ProgressView(value: 0.5)
                }
                HStack {
                    Text("Indeterminate linear")
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.linear)
                }
                HStack {
                    Text("Progress 0.5 circular")
                    Spacer()
                    ProgressView(value: 0.5)
                        .progressViewStyle(.circular)
                }
                HStack {
                    Text("Indeterminate, .tint(.red)")
                    Spacer()
                    ProgressView()
                        .tint(.red)
                }
                HStack {
                    Text("Progress 0.5, .tint(.red)")
                    Spacer()
                    ProgressView(value: 0.5)
                        .tint(.red)
                }

                // Labeled

                HStack {
                    ProgressView("Indeterminate")
                    Spacer()
                    ProgressView("Progress nil", value: nil, total: 1)
                }
                HStack {
                    ProgressView("Progress 0.5", value: 0.5)
                    Spacer()
                    ProgressView("Indeterminate linear")
                        .progressViewStyle(.linear)
                }
                HStack {
                    ProgressView("Progress 0.5 circular", value: 0.5)
                        .progressViewStyle(.circular)
                    Spacer()
                    ProgressView {
                        Text("Indeterminate")
                        Text(".tint(.red)")
                    }
                        .tint(.red)
                }
                ProgressView("Progress 0.5, .tint(.red)", value: 0.5)
                    .tint(.red)
                ProgressView(value: 2, total: 3) {
                    Text("2/3")
                    Divider()
                }

                #if SKIP
                Text("Wavy (Material 3 expressive)")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text("Indeterminate")
                    Spacer()
                    ProgressView()
                        .material3WavyProgress()
                        .composeModifier { $0.size(40.dp) }
                }
                HStack {
                    Text("Indeterminate linear")
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.linear)
                        .material3WavyProgress()
                }
                HStack {
                    Text("Progress 0.5")
                    Spacer()
                    ProgressView(value: 0.5)
                        .material3WavyProgress()
                }
                HStack {
                    Text("Progress 0.5 circular")
                    Spacer()
                    ProgressView(value: 0.5)
                        .progressViewStyle(.circular)
                        .material3WavyProgress()
                        .composeModifier { $0.size(40.dp) }
                }
                HStack {
                    Text("Custom amplitude / wavelength")
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.linear)
                        .material3WavyProgress(amplitude: 0.6, wavelength: 24)
                }
                HStack {
                    Text(".tint(.red)")
                    Spacer()
                    ProgressView(value: 0.4)
                        .tint(.red)
                        .material3WavyProgress()
                }
                #endif
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ProgressViewPlayground.swift")
        }
    }
}

#Preview {
    ProgressViewPlayground()
}
