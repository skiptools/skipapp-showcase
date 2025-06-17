// Copyright 2023–2025 Skip
import Foundation
import SwiftUI
import SkipKit

/// This component uses the `SkipKit` module from https://source.skip.tools/skip-kit
struct DocumentPickerPlayground: View {
    @State var presentPreview = false
    @State var presentCamera = false
    @State var presentMediaPicker = false
    @State var selectedDocument: URL? = nil
    @State var filename: String? = nil
    @State var mimeType: String? = nil

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Button("Pick Document") {
                    presentPreview = true
                }
                .buttonStyle(.borderedProminent)
                .withDocumentPicker(isPresented: $presentPreview, allowedContentTypes: [.image, .pdf], selectedDocumentURL: $selectedDocument, selectedFilename: $filename, selectedFileMimeType: $mimeType)

                Button("Take Photo") {
                    presentCamera = true
                }
                .buttonStyle(.borderedProminent)
                .withMediaPicker(type: .camera, isPresented: $presentCamera, selectedImageURL: $selectedDocument)

                Button("Select Media") {
                    presentMediaPicker = true
                }
                .buttonStyle(.borderedProminent)
                .withMediaPicker(type: .library, isPresented: $presentMediaPicker, selectedImageURL: $selectedDocument)
            }

            if let selectedDocument {
                Text("Selected Image: \(selectedDocument.lastPathComponent)")
                    .font(.callout)
                AsyncImage(url: selectedDocument) { image in
                    image.resizable().aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}
