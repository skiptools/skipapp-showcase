// Copyright 2023–2025 Skip
import SwiftUI

struct GeometryChangePlayground: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SizeTrackingDemo()
                PositionTrackingDemo()
                ScrollTrackingDemo()
                ExpandingTrackingDemo()
                OldNewValueDemo()
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "GeometryChangePlayground.swift")
        }
    }
}

// MARK: - Size Tracking

struct SizeTrackingDemo: View {
    @State var trackedSize: CGSize = .zero
    @State var width: CGFloat = 150

    var body: some View {
        VStack(spacing: 8) {
            Text("Size Tracking").bold()
            Text("Resize with the slider")
                .font(.caption)
                .foregroundStyle(.secondary)

            RoundedRectangle(cornerRadius: 12)
                .fill(.blue.opacity(0.3))
                .frame(width: width, height: width * 0.6)
                .onGeometryChange(for: CGSize.self) { proxy in
                    proxy.size
                } action: { newSize in
                    trackedSize = newSize
                }

            Slider(value: $width, in: 80...300)

            Text("Size: \(Int(trackedSize.width)) x \(Int(trackedSize.height))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))
    }
}

// MARK: - Position Tracking

struct PositionTrackingDemo: View {
    @State var globalFrame: CGRect = .zero

    var body: some View {
        VStack(spacing: 8) {
            Text("Position Tracking").bold()
            Text("Tracks global frame of the box below")
                .font(.caption)
                .foregroundStyle(.secondary)

            RoundedRectangle(cornerRadius: 12)
                .fill(.green.opacity(0.3))
                .frame(width: 120, height: 60)
                .onGeometryChange(for: CGRect.self) { proxy in
                    proxy.frame(in: .global)
                } action: { newFrame in
                    globalFrame = newFrame
                }

            VStack(alignment: .leading, spacing: 4) {
                Text("Origin: (\(Int(globalFrame.minX)), \(Int(globalFrame.minY)))")
                Text("Size: \(Int(globalFrame.width)) x \(Int(globalFrame.height))")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))
    }
}

// MARK: - Scroll Position Tracking

struct ScrollTrackingDemo: View {
    @State var scrollY: CGFloat = 0

    var body: some View {
        VStack(spacing: 8) {
            Text("Scroll Tracking").bold()
            Text("Scroll to see the Y offset update")
                .font(.caption)
                .foregroundStyle(.secondary)

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<20) { i in
                        Text("Row \(i)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(i % 2 == 0 ? Color.blue.opacity(0.05) : Color.clear)
                    }
                }
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.frame(in: .global).minY
                } action: { newY in
                    scrollY = newY
                }
            }
            .frame(height: 150)
            .border(Color.gray.opacity(0.3))

            Text("Content Y offset: \(Int(scrollY))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))
    }
}

// MARK: - Expanding View Tracking

struct ExpandingTrackingDemo: View {
    @State var isExpanded = false
    @State var trackedHeight: CGFloat = 0

    var body: some View {
        VStack(spacing: 8) {
            Text("Expand/Collapse Tracking").bold()

            Button(isExpanded ? "Collapse" : "Expand") {
                withAnimation {
                    isExpanded.toggle()
                }
            }

            VStack(spacing: 8) {
                Text("Header content")
                    .frame(maxWidth: .infinity, alignment: .leading)
                if isExpanded {
                    Text("Additional line 1")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Additional line 2")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Additional line 3")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(.purple.opacity(0.1)))
            .onGeometryChange(for: CGFloat.self) { proxy in
                proxy.size.height
            } action: { newHeight in
                trackedHeight = newHeight
            }

            Text("Height: \(Int(trackedHeight))")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))
    }
}

// MARK: - Old/New Value Demo

struct OldNewValueDemo: View {
    @State var width: CGFloat = 150
    @State var changeText: String = "No change yet"

    var body: some View {
        VStack(spacing: 8) {
            Text("Old/New Value Tracking").bold()
            Text("Tracks width changes with old and new values")
                .font(.caption)
                .foregroundStyle(.secondary)

            if #available(iOS 18.0, *) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.red.opacity(0.3))
                    .frame(width: width, height: 50)
                    .onGeometryChange(for: Int.self) { proxy in
                        Int(proxy.size.width)
                    } action: { (oldWidth: Int, newWidth: Int) in
                        changeText = "\(oldWidth) -> \(newWidth)"
                    }
            } else {
                // Fallback on earlier versions
            }

            Slider(value: $width, in: 80...300)

            Text("Width change: \(changeText)")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.gray.opacity(0.1)))
    }
}
