// Copyright 2023–2025 Skip
import SwiftUI

#if os(macOS)
struct PasteboardPlayground: View {
    var body: some View {
        Text("UIPasteboard is not available on macOS")
    }
}
#else
struct PasteboardPlayground: View {
    @State var pasteboardInfo = PasteboardInfo(UIPasteboard.general)
    @State var text = ""

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    TextField("Text / URL", text: $text)
                    Spacer()
                    Button("Copy") {
                        if let url = URL(string: text) {
                            UIPasteboard.general.url = url
                        } else {
                            UIPasteboard.general.string = text
                        }
                    }
                }
                Divider()
                HStack {
                    Text("Pasteboard count:")
                    Spacer()
                    Text(String(describing: pasteboardInfo.numberOfItems))
                }
                HStack {
                    Text("Has strings:")
                    Spacer()
                    Text(String(describing: pasteboardInfo.hasStrings))
                }
                HStack {
                    Text("Strings:")
                    Spacer()
                    Text("\(pasteboardInfo.strings == nil ? "nil" : pasteboardInfo.strings!.description)")
                }
                HStack {
                    Text("Has URLs:")
                    Spacer()
                    Text(String(describing: pasteboardInfo.hasURLs))
                }
                HStack {
                    Text("URLs:")
                    Spacer()
                    Text("\(pasteboardInfo.urls == nil ? "nil" : pasteboardInfo.urls!.description)")
                }
            }
            .padding()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIPasteboard.changedNotification), perform: { notification in
            pasteboardInfo = PasteboardInfo(notification.object as! UIPasteboard)
        })
        .toolbar {
            PlaygroundSourceLink(file: "PasteboardPlayground.swift")
        }
    }
}

struct PasteboardInfo {
    let numberOfItems: Int
    let hasStrings: Bool
    let strings: [String]?
    let hasURLs: Bool
    let urls: [URL]?

    init(_ pasteboard: UIPasteboard) {
        self.numberOfItems = pasteboard.numberOfItems
        self.hasStrings = pasteboard.hasStrings
        self.strings = pasteboard.strings
        self.hasURLs = pasteboard.hasURLs
        self.urls = pasteboard.urls
    }
}
#endif
