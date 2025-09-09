// Copyright 2023–2025 Skip
import SwiftUI
import SkipKeychain

struct KeychainPlayground: View {
    @State var allKeys: [String] = []

    var body: some View {
        List {
            Section {
                ForEach(allKeys, id: \.self) { key in
                    NavigationLink {
                        KeychainValueEditor(key: key, isNewKey: false)
                    } label: {
                        Text(key)
                    }
                }
                .onDelete { indices in
                    for keyIndex in indices {
                        try? Keychain.shared.removeValue(forKey: allKeys[keyIndex])
                    }
                    loadKeys()
                }
            }

            Section {
                NavigationLink {
                    KeychainValueEditor(key: "", isNewKey: true)
                } label: {
                    Text("New Key")
                }
            }
        }
        .onAppear {
            loadKeys()
        }
        .toolbar {
            PlaygroundSourceLink(file: "KeychainPlayground.swift")
        }
    }

    /// load all the keys from the keychain
    func loadKeys() {
        allKeys = ((try? Keychain.shared.keys()) ?? []).sorted()
    }
}

struct KeychainValueEditor: View {
    @State var key: String
    let isNewKey: Bool
    @State var value = ""
    @State var keychainResult = ""

    var body: some View {
        VStack {
            Form {
                TextField("Key", text: $key)
                    .disabled(!isNewKey || !value.isEmpty)

                TextField("Keychain value", text: $value)
                    .disabled(key.isEmpty)
                    .onChange(of: value) { oldValue, newValue in
                        saveToKeychain()
                    }
            }

            Divider()
            Text(keychainResult)
                .foregroundStyle(.secondary)
        }
        .onAppear {
            loadFromKeychain()
        }
        .navigationTitle("Key: \(key)")
    }

    func saveToKeychain() {
        do {
            try Keychain.shared.set(value, forKey: key, access: .unlocked)
            keychainResult = "Saved to keychain: \(key)=\(value)"
        } catch {
            keychainResult = "Error: \(error)"
        }
    }

    func loadFromKeychain() {
        if key.isEmpty {
            return
        }
        do {
            try value = Keychain.shared.string(forKey: key) ?? ""
            keychainResult = "Loaded from keychain"
        } catch {
            keychainResult = "Error: \(error)"
        }
    }
}
