// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct SheetPlayground: View {
    @State var isNavigationPresented = false
    @State var isSimplePresented = false

    var body: some View {
        VStack {
            Button("Present navigation stack sheet") {
                isNavigationPresented = true
            }
            Button("Present simple button sheet") {
                isSimplePresented = true
            }
        }
        .sheet(isPresented: $isNavigationPresented) {
            SheetContentView(dismissSheet: { isNavigationPresented = false })
        }
        .sheet(isPresented: $isSimplePresented) {
            Button("Tap to dismiss") {
                isSimplePresented = false
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "SheetPlayground.swift")
        }
    }
}

struct SheetContentView: View {
    @State var isPresented = false
    @State var counter = 0
    @Environment(\.dismiss) var dismiss
    let dismissSheet: () -> Void

    var body: some View {
        NavigationStack {
            List {
                Button("Present another") {
                    isPresented = true
                }
                Button("Dismiss via state") {
                    dismissSheet()
                }
                Button("Dismiss via environment") {
                    dismiss()
                }
                Button("Increment counter: \(counter)") {
                    counter += 1
                }
                ForEach(0..<40) { index in
                    Text("Content row \(index)")
                }
            }
            .navigationTitle("Sheet")
        }
        .sheet(isPresented: $isPresented) {
            SheetContentView(dismissSheet: { isPresented = false })
        }
    }
}

