// Copyright 2023–2026 Skip
import SwiftUI
import SkipKit

/// This component uses the `SkipKit` module from https://source.skip.tools/skip-kit
struct BiometricAuthenticationPlayground: View {
    private var canAuthenticate: Bool { BiometricAuthentication.canAuthenticate }
    @State var authenticationType = BiometricAuthentication.authenticationType
    @State var result = "Not authenticated"
    @State var authenticationAttempt = 0

    private var resultColor: Color {
        switch self.result {
        case "Authenticated": .green
        case "Cancelled": .orange
        case "Failed", "Unavailable": .red
        default:
            .secondary
        }
    }

    var body: some View {
        List {
            Section("Availability") {
                LabeledContent("Type",
                    value: {
                        switch self.authenticationType {
                        case .fingerprint: "Fingerprint"
                        case .facialRecognition: "Facial Recognition"
                        case .unspecified: "Unspecified Biometric"
                        case .none: "None"
                        }
                    }()
                )
                LabeledContent("Can Authenticate") {
                    Text(self.canAuthenticate ? "Yes" : "No")
                        .foregroundStyle(self.canAuthenticate ? Color.green : Color.red)
                }
            }

            if self.canAuthenticate {
                Section("Authentication") {
                    Button("Authenticate") { self.authenticate() }
                    
                    Text(self.result)
                        .foregroundStyle(self.resultColor)
                }
            }
        }
        .onAppear { self.refresh() }
        .onDisappear { self.cancelAuthentication() }
        .toolbar {
            PlaygroundSourceLink(file: "BiometricAuthenticationPlayground.swift")
        }
    }

    private func authenticate() {
        self.authenticationAttempt += 1
        let authenticationAttempt = self.authenticationAttempt
        self.result = "Authenticating..."

        BiometricAuthentication.authenticate(
            localizedReason: "Authenticate with biometrics"
        ) { authenticationResult in
            guard authenticationAttempt == self.authenticationAttempt else {
                return
            }

            self.result = switch authenticationResult {
            case .success: "Authenticated"
            case .cancelled: "Cancelled"
            case .failed: "Failed"
            case .unavailable: "Unavailable"
            }
            self.refresh()
        }
    }

    private func refresh() {
        self.authenticationType = BiometricAuthentication.authenticationType
    }

    private func cancelAuthentication() {
        self.authenticationAttempt += 1
    }
}
