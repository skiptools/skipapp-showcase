// Copyright 2023–2025 Skip
import SwiftUI
#if os(Android)
import SkipAuthenticationServices
#else
import AuthenticationServices
#endif

struct WebAuthenticationSessionPlayground: View {
    @Environment(\.webAuthenticationSession) private var webAuthenticationSession: WebAuthenticationSession
    @State private var resultURL: URL?
    @State private var errorMessage: String?
    @State private var cancelled = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Button("Sign In") {
                    signIn()
                }
                .buttonStyle(.borderedProminent)
                
                if let resultURL = resultURL {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Result URL:")
                            .font(.headline)
                        Text(resultURL.absoluteString)
                            .font(.system(.body, design: .monospaced))
                        
                        if let components = URLComponents(url: resultURL, resolvingAgainstBaseURL: false) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("URL Components:")
                                    .font(.headline)
                                    .padding(.top)
                                
                                if let scheme = components.scheme {
                                    Text("scheme: \(scheme)")
                                }
                                
                                if let host = components.host {
                                    Text("host: \(host)")
                                }
                                
                                if !components.path.isEmpty {
                                    Text("path: \(components.path)")
                                }
                                
                                if let queryItems = components.queryItems {
                                    ForEach(queryItems, id: \.name) { item in
                                        Text("\(item.name): \(item.value ?? "")")
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                }
                
                if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }
                if cancelled {
                    Text("The user cancelled the sign-in process.")
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Web Authentication Session")
        .toolbar {
            PlaygroundSourceLink(file: "WebAuthenticationSessionPlayground.swift")
        }
    }
    
    private func signIn() {
        errorMessage = nil
        cancelled = false
        resultURL = nil
        
        Task {
            do {
                let urlWithToken: URL
                if #available(iOS 17.4, *) {
                    urlWithToken = try await webAuthenticationSession.authenticate(
                        using: URL(string: "https://skip.tools/docs/samples/webauth-demo/?scheme=org.appfair.app.showcaselite")!,
                        callback: .customScheme("org.appfair.app.showcaselite"),
                        preferredBrowserSession: .ephemeral,
                        additionalHeaderFields: [:]
                    )
                } else {
                    urlWithToken = try await webAuthenticationSession.authenticate(
                        using: URL(string: "https://skip.tools/docs/samples/webauth-demo/?scheme=org.appfair.app.showcaselite")!,
                        callbackURLScheme: "org.appfair.app.showcaselite",
                        preferredBrowserSession: .ephemeral
                    )
                }
                
                resultURL = urlWithToken
            } catch {
                logger.error("error: \(error)")
                if let error = error as? ASWebAuthenticationSessionError, error.code == ASWebAuthenticationSessionError.canceledLogin {
                    cancelled = true
                } else {
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}
