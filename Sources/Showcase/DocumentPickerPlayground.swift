// Copyright 2023–2025 Skip
import Foundation
import SwiftUI
import SkipKit

/// This component uses the `SkipKit` module from https://source.skip.tools/skip-kit
struct DocumentPickerPlayground: View {
    @State var presentPreview = false
    @State var selectedDocument: URL? = nil
    @State var filename: String? = nil
    @State var mimeType: String? = nil

    var body: some View {
        VStack(alignment: .center) {
            Button("Pick Document") {
                presentPreview = true
            }
            .buttonStyle(.borderedProminent)
            .withDocumentPicker(isPresented: $presentPreview, allowedContentTypes: [.image, .pdf], selectedDocumentURL: $selectedDocument, selectedFilename: $filename, selectedFileMimeType: $mimeType)

            if let selectedDocument {
                Text("Document: \(selectedDocument.lastPathComponent)")
            }

            if let filename {
                Text("Filename: \(filename)")
            }

            if let mimeType {
                Text("Mime Type: \(mimeType)")
            }
        }
    }
}
