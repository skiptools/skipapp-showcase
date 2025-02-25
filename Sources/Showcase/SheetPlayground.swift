// Copyright 2023–2025 Skip
import SwiftUI

struct SheetPlayground: View {
    struct Item: Identifiable {
        var id: Int
    }

    @State var isSheetPresented = false
    @State var isSimpleSheetPresented = false
    @State var isDetentSheetPresented = false
    @State var isFullScreenPresented = false
    @State var isSimpleFullScreenPresented = false
    @State var item: Item? = nil
    @State var itemID = 0

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
        .sheet(isPresented: $isSheetPresented, onDismiss: { logger.info("onDismiss called") }) {
            SheetContentView(dismissSheet: { isSheetPresented = false })
        }
        .sheet(isPresented: $isSimpleSheetPresented, onDismiss: { logger.info("onDismiss called") }) {
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
            Button("Present item sheet: \(itemID + 1)") {
                itemID += 1
                item = Item(id: itemID)
            }
            Button("Present full screen cover with navigation stack") {
                isFullScreenPresented = true
            }
            Button("Present full screen cover with simple content") {
                isSimpleFullScreenPresented = true
            }
        }
        .sheet(isPresented: $isSheetPresented, onDismiss: { logger.info("onDismiss called") }) {
            SheetContentView(dismissSheet: { isSheetPresented = false })
        }
        .sheet(isPresented: $isSimpleSheetPresented, onDismiss: { logger.info("onDismiss called") }) {
            Button("Back button is disabled. Tap to dismiss") {
                isSimpleSheetPresented = false
            }
            #if os(Android)
            .backDismissDisabled()
            #endif
        }
        .sheet(item: $item, onDismiss: { logger.info("onDismiss called") }) { value in
            VStack(spacing: 16) {
                Text("Value: \(value.id)")
                Button("Tap to dismiss") {
                    item = nil
                }
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
            Button("Back button is disabled. Tap to dismiss") {
                isSimpleFullScreenPresented = false
            }
            #if os(Android)
            .backDismissDisabled()
            #endif
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
    @State var text = ""
    @State var interactiveDismissDisabled = false
    @Environment(\.dismiss) var dismiss
    let dismissSheet: () -> Void

    var body: some View {
        NavigationStack {
            List {
                TextField("Text", text: $text)
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
                Button("Interactive dismiss: \(interactiveDismissDisabled ? "disabled" : "enabled")") {
                    interactiveDismissDisabled = !interactiveDismissDisabled
                }
                ForEach(0..<40) { index in
                    Text("Content row \(index)")
                }
            }
            .interactiveDismissDisabled(interactiveDismissDisabled)
            .navigationTitle("Sheet")
        }
        .sheet(isPresented: $isPresented) {
            SheetContentView(dismissSheet: { isPresented = false })
        }
    }
}

