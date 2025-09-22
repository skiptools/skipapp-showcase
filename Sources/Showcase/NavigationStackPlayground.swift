// Copyright 2023–2025 Skip
import SwiftUI

struct NavigationStackPlayground: View {
    @Environment(\.dismiss) var dismiss
    @State var isPathBindingSheetPresented = false
    @State var isPathBindingSheetWithInitialStackPresented = false
    @State var isNavigationPathBindingSheetPresented = false
    @State var nextIsPresented = false

    var body: some View {
        VStack(spacing: 16) {
            Button("Pop") {
                dismiss()
            }
            Button("Present with binding") {
                nextIsPresented = true
            }
            Button("Path binding sheet") {
                isPathBindingSheetPresented = true
            }
            Button("Path binding sheet with initial stack") {
                isPathBindingSheetWithInitialStackPresented = true
            }
            Button("NavigationPath binding sheet") {
                isNavigationPathBindingSheetPresented = true
            }
            Divider()
            NavigationLink("NavigationLink") {
                Text("Pushed")
            }
            NavigationLink("NavigationLink .buttonStyle") {
                Text("Pushed")
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationDestination(isPresented: $nextIsPresented) {
            Text("Pushed")
        }
        .sheet(isPresented: $isPathBindingSheetPresented) {
            PathBindingSheetContentView()
        }
        .sheet(isPresented: $isPathBindingSheetWithInitialStackPresented) {
            PathBindingSheetContentView(initialPath: [PathElement(rawValue: 1), PathElement(rawValue: 2)])
        }
        .sheet(isPresented: $isNavigationPathBindingSheetPresented) {
            NavigationPathBindingSheetContentView()
        }
        .toolbar {
            PlaygroundSourceLink(file: "NavigationStackPlayground.swift")
        }
    }
}

struct PathBindingSheetContentView: View {
    @Environment(\.dismiss) var dismiss
    @State var path: [PathElement] = []

    init(initialPath: [PathElement] = []) {
        path.append(contentsOf: initialPath)
    }

    var body: some View {
        NavigationStack(path: $path) {
            PathElementView(element: PathElement(rawValue: 0), path: $path)
                .navigationDestination(for: PathElement.self) { element in
                    PathElementView(element: element, path: $path)
                }
                #if os(macOS)
                .toolbar {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
                #else
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
                #endif
        }
    }
}

struct NavigationPathBindingSheetContentView: View {
    @Environment(\.dismiss) var dismiss
    @State var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            NavigationPathElementView(element: PathElement(rawValue: 0), path: $path)
                .navigationDestination(for: PathElement.self) { element in
                    NavigationPathElementView(element: element, path: $path)
                }
                .navigationDestination(for: String.self) { value in
                    VStack(spacing: 16) {
                        Text("Value: \(value)")
                        Button("path.append(\(value + " X "))") {
                            path.append(value + " X ")
                        }
                        Button("path.removeLast()") {
                            path.removeLast()
                        }
                    }
                    #if os(macOS)
                    .navigationTitle(value)
                    #else
                    .navigationTitle(value)
                    .navigationBarTitleDisplayMode(.large)
                    #endif
                }
                #if os(macOS)
                .toolbar {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
                #else
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
                #endif
        }
    }
}

struct PathElement: RawRepresentable, Hashable, CustomStringConvertible {
    let rawValue: Int
    var description: String {
        return rawValue.description
    }
}

struct PathElementView: View {
    @Environment(\.dismiss) var dismiss
    let element: PathElement
    @Binding var path: [PathElement]

    var body: some View {
        VStack(spacing: 16) {
            Text("Path: \(path.map(\.description).joined(separator: ", "))")
            NavigationLink("Navigate forward", value: PathElement(rawValue: maxElement() + 1))
            if !path.isEmpty {
                Button("Navigate back") {
                    dismiss()
                }
            }
            Button("path.append(\(maxElement() + 1))") {
                path.append(PathElement(rawValue: maxElement() + 1))
            }
            Button("path += [\(maxElement() + 1), \(maxElement() + 2)]") {
                path += [PathElement(rawValue: maxElement() + 1), PathElement(rawValue: maxElement() + 2)]
            }
            if !path.isEmpty {
                Button("path.removeLast()") {
                    path.removeLast()
                }
            }
            if path.count >= 2 {
                Button("path.removeLast(2)") {
                    path.removeLast(2)
                }
                Button("path.removeLast(2); path.append(\(maxElement() + 1))") {
                    let next = PathElement(rawValue: maxElement() + 1)
                    path.removeLast(2)
                    path.append(next)
                }
                Button("path.reverse()") {
                    path.reverse()
                }
            }
        }
        .navigationTitle(element.description)
    }

    private func maxElement() -> Int {
        return path.max(by: { $0.rawValue < $1.rawValue })?.rawValue ?? 0
    }
}

struct NavigationPathElementView: View {
    @Environment(\.dismiss) var dismiss
    let element: PathElement
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 16) {
            Text("Path count: \(path.count)")
            NavigationLink("Navigate forward", value: PathElement(rawValue: path.count + 1))
            if !path.isEmpty {
                Button("Navigate back") {
                    dismiss()
                }
            }
            Button("path.append(\(path.count + 1))") {
                path.append(PathElement(rawValue: path.count + 1))
            }
            Button("path += [\(path.count + 1), \(path.count + 2)]") {
                let count = path.count
                path.append(PathElement(rawValue: count + 1))
                path.append(PathElement(rawValue: count + 2))
            }
            Button("path.append(\"X\")") {
                path.append("X")
            }
            if !path.isEmpty {
                Button("path.removeLast()") {
                    path.removeLast()
                }
            }
            if path.count >= 2 {
                Button("path.removeLast(2)") {
                    path.removeLast(2)
                }
            }
        }
        .navigationTitle(element.description)
    }
}
