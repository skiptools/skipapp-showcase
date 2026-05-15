// Copyright 2023–2026 Skip
import SwiftUI

// In Lite (transpiled) mode this playground uses Fuse-only API surfaces or
// Kotlin/Compose helpers that the transpiled SkipUI does not yet expose, so
// the original implementation is kept for Fuse only and Lite gets a stub.
#if SKIP_MODE_FUSE
//#if SKIP
//import androidx.compose.foundation.background
//import androidx.compose.foundation.layout.fillMaxWidth
//#endif

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
                // BackgroundModifier is only declared in the `#if SKIP` block
                // below (Lite/transpiled mode), so the call site is gated to
                // SKIP as well rather than os(Android).
                #if SKIP
                .composeModifier {
                    BackgroundModifier()
                }
                #endif
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
#else
struct ModifierPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("ModifierPlayground uses ContentModifier with .composeModifier(), a Fuse-only extension.")
                .multilineTextAlignment(.center)
                .padding()
            Text("Run the app with SKIP_MODE=fuse to see this playground.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "ModifierPlayground.swift")
        }
    }
}
#endif
