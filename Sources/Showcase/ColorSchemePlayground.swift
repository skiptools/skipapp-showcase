// Copyright 2023–2025 Skip
import SwiftUI

struct ColorSchemePlayground: View {
    @State var isDarkMode = false
    @State var preferredColorScheme = ""
    @State var isPresented = false

    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("This text is in \(isDarkMode ? "Dark" : "Light") mode")
                    .font(.largeTitle)
                Button("Toggle") {
                    isDarkMode = !isDarkMode
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(32)
            .background()
            .padding(32)
            .colorScheme(isDarkMode ? .dark : .light)
            Picker(".preferredColorScheme", selection: $preferredColorScheme) {
                Text("System").tag("")
                Text("Light").tag("light")
                Text("Dark").tag("dark")
            }
            NavigationLink("Push") {
                Text("Pushed")
            }
            Button("Present") {
                isPresented = true
            }
        }
        .preferredColorScheme(namedColorScheme(for: preferredColorScheme))
        .sheet(isPresented: $isPresented) {
            ColorSchemeSheetView()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ColorSchemePlayground.swift")
        }
    }
}

struct ColorSchemeSheetView: View {
    @Environment(\.dismiss) var dismiss
    @State var preferredColorScheme = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker(".preferredColorScheme", selection: $preferredColorScheme) {
                    Text("System").tag("")
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }
                NavigationLink("Push") {
                    Text("Pushed")
                }
            }
            .preferredColorScheme(namedColorScheme(for: preferredColorScheme))
            .navigationTitle("Sheet")
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

private func namedColorScheme(for string: String) -> ColorScheme? {
    switch string {
    case "light":
        return .light
    case "dark":
        return .dark
    default:
        return nil
    }
}
