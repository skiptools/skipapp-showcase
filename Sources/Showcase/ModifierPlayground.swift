// Copyright 2023–2025 Skip
import SwiftUI

struct ModifierPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("This text uses a custom modifier that adds a Dismiss button to the navigation bar above")
                .dismissable()
                .toolbar {
                    PlaygroundSourceLink(file: "ModifierPlayground.swift")
                }
            Text("This is text that uses a function that returns EmptyModifier()")
                .modifier(someModifier)
            Text(".composeModifier()")
//                #if os(Android)
//                .composeModifier {
//                    #if SKIP // Skip Lite mode
//                    $0.background(androidx.compose.ui.graphics.Color.Yellow).fillMaxWidth()
//                    #elseif !SKIP_BRIDGE // Skip Fuse mode
//                    BackgroundModifier()
//                    #endif
//                }
//                #endif
        }
        .padding()
    }

    private var someModifier: some ViewModifier {
        return EmptyModifier()
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

#if SKIP
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.fillMaxWidth

struct BackgroundModifier : ContentModifier {
    func modify(view: any View) -> any View {
        view.composeModifier {
            $0.background(androidx.compose.ui.graphics.Color.Yellow).fillMaxWidth()
        }
    }
}
#endif
