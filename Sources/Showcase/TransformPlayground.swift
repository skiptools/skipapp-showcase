// Copyright 2023–2026 Skip
import SwiftUI

// In Lite (transpiled) mode this playground uses Fuse-only API surfaces or
// Kotlin/Compose helpers that the transpiled SkipUI does not yet expose, so
// the original implementation is kept for Fuse only and Lite gets a stub.
#if SKIP_FUSE_MODE
struct TransformPlayground: View {
    enum Tab: String, CaseIterable {
        case rotation = "Rotation"
        case scale = "Scale"
        case combined = "Combined"
    }

    @State internal var selectedTab: Tab = .rotation
    @State internal var rotationAngle: Double = 0
    @State internal var scale: Double = 1.0
    @State internal var selectedAnchor: AnchorChoice = .center

    enum AnchorChoice: String, CaseIterable {
        case topLeading, top, topTrailing
        case leading, center, trailing
        case bottomLeading, bottom, bottomTrailing

        var unitPoint: UnitPoint {
            switch self {
            case .topLeading: return .topLeading
            case .top: return .top
            case .topTrailing: return .topTrailing
            case .leading: return .leading
            case .center: return .center
            case .trailing: return .trailing
            case .bottomLeading: return .bottomLeading
            case .bottom: return .bottom
            case .bottomTrailing: return .bottomTrailing
            }
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            Picker("Demo", selection: $selectedTab) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Text(tab.rawValue).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            Divider()

            switch selectedTab {
            case .rotation:
                rotationTab
            case .scale:
                scaleTab
            case .combined:
                combinedTab
            }
        }
        .toolbar {
            PlaygroundSourceLink(file: "TransformPlayground.swift")
        }
    }

    // MARK: - Rotation Tab

    private var rotationTab: some View {
        VStack(spacing: 16) {
            Spacer()

            transformPreview(color: .blue) {
                $0.rotationEffect(.degrees(rotationAngle), anchor: selectedAnchor.unitPoint)
            }

            Text("rotationEffect(.\(selectedAnchor.rawValue))")
                .font(.headline)
                .monospaced()

            Spacer()

            controlsSection {
                sliderRow(label: "Angle", value: $rotationAngle, range: -180...180, format: "%.0f°")
            }
        }
    }

    // MARK: - Scale Tab

    private var scaleTab: some View {
        VStack(spacing: 16) {
            Spacer()

            transformPreview(color: .green) {
                $0.scaleEffect(scale, anchor: selectedAnchor.unitPoint)
            }

            Text("scaleEffect(.\(selectedAnchor.rawValue))")
                .font(.headline)
                .monospaced()

            Spacer()

            controlsSection {
                sliderRow(label: "Scale", value: $scale, range: 0.25...2.0, format: "%.2fx")
            }
        }
    }

    // MARK: - Combined Tab

    private var combinedTab: some View {
        VStack(spacing: 16) {
            Spacer()

            transformPreview(color: .purple) {
                $0.rotationEffect(.degrees(rotationAngle), anchor: selectedAnchor.unitPoint)
                    .scaleEffect(scale, anchor: selectedAnchor.unitPoint)
            }

            Text("rotation + scale (.\(selectedAnchor.rawValue))")
                .font(.headline)
                .monospaced()

            Spacer()

            controlsSection {
                sliderRow(label: "Angle", value: $rotationAngle, range: -180...180, format: "%.0f°")
                sliderRow(label: "Scale", value: $scale, range: 0.25...2.0, format: "%.2fx")
            }
        }
    }

    // MARK: - Reusable Components

    private func transformPreview<V: View>(color: Color, @ViewBuilder transform: @escaping (AnyView) -> V) -> some View {
        ZStack {
            anchorDot

            transform(AnyView(
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.opacity(0.8))
                    .frame(width: 100, height: 100)
            ))
        }
        .frame(width: 220, height: 220)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.15))
        )
        .clipped()
    }

    private var anchorDot: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 10, height: 10)
            .shadow(color: .red.opacity(0.5), radius: 4)
            .position(anchorPosition(in: CGSize(width: 100, height: 100)))
    }

    private func controlsSection<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 12) {
            anchorPicker
            content()
            resetButton
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }

    private var anchorPicker: some View {
        HStack {
            Text("Anchor")
                .frame(width: 60, alignment: .leading)
            Picker("Anchor", selection: $selectedAnchor) {
                ForEach(AnchorChoice.allCases, id: \.self) { anchor in
                    Text(anchor.rawValue).tag(anchor)
                }
            }
            .pickerStyle(.menu)
            Spacer()
        }
    }

    private func sliderRow(label: String, value: Binding<Double>, range: ClosedRange<Double>, format: String) -> some View {
        HStack {
            Text(label)
                .frame(width: 60, alignment: .leading)
            Slider(value: value, in: range)
            Text(String(format: format, value.wrappedValue))
                .frame(width: 50, alignment: .trailing)
                .monospaced()
        }
    }

    private var resetButton: some View {
        Button("Reset") {
            withAnimation(.easeInOut(duration: 0.3)) {
                rotationAngle = 0
                scale = 1.0
                selectedAnchor = .center
            }
        }
        .buttonStyle(.bordered)
    }

    private func anchorPosition(in size: CGSize) -> CGPoint {
        let anchor = selectedAnchor.unitPoint
        let centerX: CGFloat = 110
        let centerY: CGFloat = 110
        return CGPoint(
            x: centerX + (anchor.x - 0.5) * size.width,
            y: centerY + (anchor.y - 0.5) * size.height
        )
    }
}
#else
struct TransformPlayground: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("TransformPlayground passes IntRange to Slider(in: ClosedRange<Double>).")
                .multilineTextAlignment(.center)
                .padding()
            Text("Run the app with SKIP_MODE=fuse to see this playground.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .toolbar {
            PlaygroundSourceLink(file: "TransformPlayground.swift")
        }
    }
}
#endif
