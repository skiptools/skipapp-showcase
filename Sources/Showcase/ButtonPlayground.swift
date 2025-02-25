// Copyright 2023–2025 Skip
import SwiftUI

struct ButtonPlayground: View {
    @State var tapCount = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Button(action: { tapCount += 1 }) {
                    Text(".init(action:label:): \(tapCount)")
                }
                Button(".init(_ label:action:): \(tapCount)") {
                    tapCount += 1
                }
                Button {
                    tapCount += 1
                } label: {
                    Label("Label", systemImage: "bell.fill")
                }
                Button(".destructive: \(tapCount)", role: .destructive) {
                    tapCount += 1
                }
                Button(role: .destructive) {
                    tapCount += 1
                } label: {
                    Label(".destructive", systemImage: "bell.fill")
                }
                Button(".plain: \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.plain)
                Button(".bordered: \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.bordered)
                Button {
                    tapCount += 1
                } label: {
                    Label(".bordered", systemImage: "bell.fill")
                }
                .buttonStyle(.bordered)
                Button(".borderedProminent: \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.borderedProminent)
                Button(".borderedProminent, .destructive: \(tapCount)", role: .destructive) {
                    tapCount += 1
                }
                .buttonStyle(.borderedProminent)
                Button {
                    tapCount += 1
                } label: {
                    Label(".borderedProminent", systemImage: "bell.fill")
                }
                .buttonStyle(.borderedProminent)
                Button(".disabled(true): \(tapCount)") {
                    tapCount += 1
                }
                .disabled(true)
                Button {
                    tapCount += 1
                } label: {
                    Label(".disabled(true)", systemImage: "bell.fill")
                }
                .disabled(true)
                Button(".plain, .disabled(true): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.plain)
                .disabled(true)
                Button(".bordered, .disabled(true): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.bordered)
                .disabled(true)
                Button {
                    tapCount += 1
                } label: {
                    Label(".bordered, .disabled(true)", systemImage: "bell.fill")
                }
                .buttonStyle(.bordered)
                .disabled(true)
                Button(".borderedProminent, .disabled(true): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.borderedProminent)
                .disabled(true)
                Button {
                    tapCount += 1
                } label: {
                    Label(".borderedProminent, .disabled(true)", systemImage: "bell.fill")
                }
                .buttonStyle(.borderedProminent)
                .disabled(true)
                Button(".foregroundStyle(.red): \(tapCount)") {
                    tapCount += 1
                }
                .foregroundStyle(.red)
                Button {
                    tapCount += 1
                } label: {
                    Label(".foregroundStyle(.red)", systemImage: "bell.fill")
                }
                .foregroundStyle(.red)
                Button(".foregroundStyle(.red), .disabled(true): \(tapCount)") {
                    tapCount += 1
                }
                .foregroundStyle(.red)
                .disabled(true)
                Button {
                    tapCount += 1
                } label: {
                    Label(".foregroundStyle(.red), .disabled(true)", systemImage: "bell.fill")
                }
                .foregroundStyle(.red)
                .disabled(true)
                Button(".tint(.red): \(tapCount)") {
                    tapCount += 1
                }
                .tint(.red)
                Button {
                    tapCount += 1
                } label: {
                    Label(".tint(.red)", systemImage: "bell.fill")
                }
                .tint(.red)
                Button(".tint(.red), .disabled(true): \(tapCount)") {
                    tapCount += 1
                }
                .tint(.red)
                .disabled(true)
                Button {
                    tapCount += 1
                } label: {
                    Label(".tint(.red), .disabled(true)", systemImage: "bell.fill")
                }
                .tint(.red)
                .disabled(true)
                Button(".bordered, .foregroundStyle(.red): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.bordered)
                .foregroundStyle(.red)
                Button {
                    tapCount += 1
                } label: {
                    Label(".bordered, .foregroundStyle(.red)", systemImage: "bell.fill")
                }
                .buttonStyle(.bordered)
                .foregroundStyle(.red)
                Button(".bordered, .tint(.red): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.bordered)
                .tint(.red)
                Button {
                    tapCount += 1
                } label: {
                    Label(".bordered, .tint(.red)", systemImage: "bell.fill")
                }
                .buttonStyle(.bordered)
                .tint(.red)
                Button(".borderedProminent, .foregroundStyle(.red): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.red)
                Button {
                    tapCount += 1
                } label: {
                    Label(".borderedProminent, .foregroundStyle(.red)", systemImage: "bell.fill")
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.red)
                Button(".borderedProminent, .tint(.red): \(tapCount)") {
                    tapCount += 1
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                Button {
                    tapCount += 1
                } label: {
                    Label(".borderedProminent, .tint(.red)", systemImage: "bell.fill")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ButtonPlayground.swift")
        }
    }
}
