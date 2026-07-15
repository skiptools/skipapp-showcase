// Copyright 2023–2026 Skip
import Foundation
import SwiftUI
import SkipKit

/// This component uses the `SkipKit` module from https://source.skip.tools/skip-kit
struct DocumentPickerPlayground: View {
    @State var presentPreview = false
    @State var presentCamera = false
    @State var presentMediaPicker = false

    @State var allowsMultipleSelection = true

    @State var selectedDocumentURLs: [URL] = []
    @State var selectedFilenames: [String] = []
    @State var selectedFileMimeTypes: [String] = []
    @State var selectedMediaURLs: [URL] = []
    @State var resultItems: [ResultItem] = []
    @State var resultItemHeights: [String: Double] = [:]

    struct ResultItem: Identifiable {
        let id: String
        let url: URL
        let documentIndex: Int?
    }

    private var appendingDocumentURLs: Binding<[URL]> {
        Binding(
            get: { [] },
            set: { urls in
                let startIndex = selectedDocumentURLs.count
                selectedDocumentURLs.append(contentsOf: urls)
                for (offset, url) in urls.enumerated() {
                    resultItems.append(
                        ResultItem(
                            id: "document-\(url.absoluteString)",
                            url: url,
                            documentIndex: startIndex + offset
                        )
                    )
                }
            }
        )
    }

    private var appendingFilenames: Binding<[String]> {
        Binding(
            get: { [] },
            set: { selectedFilenames.append(contentsOf: $0) }
        )
    }

    private var appendingFileMimeTypes: Binding<[String]> {
        Binding(
            get: { [] },
            set: { selectedFileMimeTypes.append(contentsOf: $0) }
        )
    }

    private var appendingMediaURLs: Binding<[URL]> {
        Binding(
            get: { [] },
            set: { urls in
                selectedMediaURLs.append(contentsOf: urls)
                for url in urls {
                    resultItems.append(
                        ResultItem(
                            id: "media-\(url.absoluteString)",
                            url: url,
                            documentIndex: nil
                        )
                    )
                }
            }
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .center, spacing: 8) {
                    Button {
                        presentCamera = true
                    } label: {
                        Text("Take Photo")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.borderedProminent)
                    .withMediaPicker(
                        type: .camera,
                        isPresented: $presentCamera,
                        allowsMultipleSelection: false,
                        selectedImageURLs: appendingMediaURLs
                    )

                    Button {
                        presentPreview = true
                    } label: {
                        Text(allowsMultipleSelection ? "Pick Documents" : "Pick Document")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.borderedProminent)
                    .withDocumentPicker(
                        isPresented: $presentPreview,
                        allowedContentTypes: [.image, .pdf],
                        allowsMultipleSelection: allowsMultipleSelection,
                        selectedDocumentURLs: appendingDocumentURLs,
                        selectedFilenames: appendingFilenames,
                        selectedFileMimeTypes: appendingFileMimeTypes
                    )

                    Button {
                        presentMediaPicker = true
                    } label: {
                        Text(allowsMultipleSelection ? "Pick Photos" : "Pick Photo")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.borderedProminent)
                    .withMediaPicker(
                        type: .library,
                        isPresented: $presentMediaPicker,
                        allowsMultipleSelection: allowsMultipleSelection,
                        selectedImageURLs: appendingMediaURLs
                    )

                    Toggle("Allows Multiple Selection", isOn: $allowsMultipleSelection)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)

                HStack(alignment: .top, spacing: 12) {
                    resultColumn(0)
                    resultColumn(1)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 20)
        }
    }

    private var resultColumns: [[ResultItem]] {
        var columns = Array(repeating: [ResultItem](), count: 2)
        var columnHeights = Array(repeating: 0.0, count: 2)

        for item in resultItems {
            let column = columnHeights[0] <= columnHeights[1] ? 0 : 1
            columns[column].append(item)
            if let height = resultItemHeights[item.id] {
                columnHeights[column] += height
            } else {
                columnHeights[column] += 150
            }
        }

        return columns
    }

    private func resultColumn(_ column: Int) -> some View {
        VStack(spacing: 12) {
            ForEach(resultColumns[column]) { item in
                Group {
                    if let documentIndex = item.documentIndex {
                        documentTile(
                            url: item.url,
                            title: filename(at: documentIndex, fallback: item.url.lastPathComponent)
                        )
                    } else {
                        mediaTile(url: item.url)
                    }
                }
                .background {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                resultItemHeights[item.id] = geometry.size.height
                            }
                            .onChange(of: geometry.size.height) { _, height in
                                resultItemHeights[item.id] = height
                            }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func mediaTile(url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
        }
        .frame(maxWidth: .infinity)
        .background(Color.secondary.opacity(0.12))
        .overlay(alignment: .bottomLeading) {
            Text(url.lastPathComponent)
                .font(.caption)
                .lineLimit(1)
                .padding(6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.white)
                .background(Color.black.opacity(0.55))
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func documentTile(url: URL, title: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: "doc")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, minHeight: 76)

            Text(title)
                .font(.callout)
                .lineLimit(2)

            Text(url.pathExtension.uppercased())
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
        .background(Color.secondary.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private func filename(at index: Int, fallback: String) -> String {
        guard selectedFilenames.indices.contains(index) else {
            return fallback
        }

        return selectedFilenames[index]
    }
}
