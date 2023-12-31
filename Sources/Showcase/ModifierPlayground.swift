// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct ModifierPlayground: View {
    var body: some View {
        Text("This text uses a custom modifier that adds a Dismiss button to the navigation bar above")
            .padding()
            .dismissable()
            .toolbar {
                PlaygroundSourceLink(file: "ModifierPlayground.swift")
            }
    }
}

extension View {
    public func dismissable() -> some View {
        modifier(DismissModifier())
    }
}

struct DismissModifier: ViewModifier {
    @State var isConfirmationPresented = false
    @Environment(\.dismiss) var dismiss

    func body(content: Content) -> some View {
        content
            .toolbar {
                Button(action: { isConfirmationPresented = true }) {
                    Label("Dismiss", systemImage: "trash")
                }
            }
            .confirmationDialog("Dismiss", isPresented: $isConfirmationPresented) {
                Button("Dismiss", role: .destructive, action: { dismiss() })
            }
    }
}
