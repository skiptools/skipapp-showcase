// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

struct SheetPlayground: View {
    @State var isSheetPresented = false
    @State var isSimpleSheetPresented = false
    @State var isDetentSheetPresented = false
    @State var isFullScreenPresented = false
    @State var isSimpleFullScreenPresented = false

    var body: some View {
        #if os(macOS)
        VStack(spacing: 16) {
            Button("Present sheet with navigation stack") {
                isSheetPresented = true
            }
            Button("Present sheet with simple content") {
                isSimpleSheetPresented = true
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetContentView(dismissSheet: { isSheetPresented = false })
        }
        .sheet(isPresented: $isSimpleSheetPresented) {
            Button("Tap to dismiss") {
                isSimpleSheetPresented = false
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "SheetPlayground.swift")
        }
        #else
        VStack(spacing: 16) {
            Button("Present sheet with navigation stack") {
                isSheetPresented = true
            }
            Button("Present sheet with simple content") {
                isSimpleSheetPresented = true
            }
            Button("Present sheet with medium detent") {
                isDetentSheetPresented = true
            }
            Button("Present full screen cover with navigation stack") {
                isFullScreenPresented = true
            }
            Button("Present full screen cover with simple content") {
                isSimpleFullScreenPresented = true
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetContentView(dismissSheet: { isSheetPresented = false })
        }
        .sheet(isPresented: $isSimpleSheetPresented) {
            Button("Tap to dismiss") {
                isSimpleSheetPresented = false
            }
        }
        .sheet(isPresented: $isDetentSheetPresented, content: {
            Button("Tap to dismiss") {
                isDetentSheetPresented = false
            }
            .presentationDetents([.medium])
        })
        .fullScreenCover(isPresented: $isFullScreenPresented) {
            SheetContentView(dismissSheet: { isFullScreenPresented = false })
        }
        .fullScreenCover(isPresented: $isSimpleFullScreenPresented) {
            Button("Tap to dismiss") {
                isSimpleFullScreenPresented = false
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "SheetPlayground.swift")
        }
        #endif
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

