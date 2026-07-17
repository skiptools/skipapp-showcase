// Copyright 2023–2025 Skip
import SwiftUI
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
typealias UIFont = NSFont
#endif

struct ScaledMetricPlayground: View {
    @ScaledMetric private var defaultScaledHeight: Double = Self.baseSize(for: .body)
    @ScaledMetric(relativeTo: Font.TextStyle.body) private var bodyScaledHeight: Double = Self.baseSize(for: .body)
    @ScaledMetric(relativeTo: Font.TextStyle.largeTitle) private var largeTitleScaledHeight: Double = Self.baseSize(for: .largeTitle)
    @ScaledMetric(relativeTo: Font.TextStyle.title) private var titleScaledHeight: Double = Self.baseSize(for: .title)
    @ScaledMetric(relativeTo: Font.TextStyle.title2) private var title2ScaledHeight: Double = Self.baseSize(for: .title2)
    @ScaledMetric(relativeTo: Font.TextStyle.title3) private var title3ScaledHeight: Double = Self.baseSize(for: .title3)
    @ScaledMetric(relativeTo: Font.TextStyle.headline) private var headlineScaledHeight: Double = Self.baseSize(for: .headline)
    @ScaledMetric(relativeTo: Font.TextStyle.subheadline) private var subheadlineScaledHeight: Double = Self.baseSize(for: .subheadline)
    @ScaledMetric(relativeTo: Font.TextStyle.callout) private var calloutScaledHeight: Double = Self.baseSize(for: .callout)
    @ScaledMetric(relativeTo: Font.TextStyle.footnote) private var footnoteScaledHeight: Double = Self.baseSize(for: .footnote)
    @ScaledMetric(relativeTo: Font.TextStyle.caption) private var captionScaledHeight: Double = Self.baseSize(for: .caption)
    @ScaledMetric(relativeTo: Font.TextStyle.caption2) private var caption2ScaledHeight: Double = Self.baseSize(for: .caption2)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Body + default/body ScaledMetric")
                    .font(.headline)

                HStack(alignment: .center, spacing: 12) {
                    Text("Body")
                        .font(.body)
                        .border(.primary)
                    metricBar(defaultScaledHeight, color: .blue, label: "Body default rectangle")
                    metricBar(bodyScaledHeight, color: .green, label: "Body relativeTo body rectangle")
                }

                Divider()

                styledRow("LargeTitle", font: .largeTitle, height: largeTitleScaledHeight, color: .orange)
                styledRow("Title", font: .title, height: titleScaledHeight, color: .pink)
                styledRow("Title2", font: .title2, height: title2ScaledHeight, color: .purple)
                styledRow("Title3", font: .title3, height: title3ScaledHeight, color: .mint)
                styledRow("Headline", font: .headline, height: headlineScaledHeight, color: .teal)
                styledRow("Subheadline", font: .subheadline, height: subheadlineScaledHeight, color: .indigo)
                styledRow("Callout", font: .callout, height: calloutScaledHeight, color: .cyan)
                styledRow("Footnote", font: .footnote, height: footnoteScaledHeight, color: .brown)
                styledRow("Caption", font: .caption, height: captionScaledHeight, color: .red)
                styledRow("Caption2", font: .caption2, height: caption2ScaledHeight, color: .gray)
            }
            .padding()
        }
        .toolbar {
            PlaygroundSourceLink(file: "ScaledMetricPlayground.swift")
        }
    }

    private func styledRow(_ label: String, font: Font, height: Double, color: Color) -> some View {
        HStack(alignment: .center, spacing: 12) {
            Text(label)
                .font(font)
                .border(.primary)
            metricBar(height, color: color, label: "\(label) rectangle")
        }
    }

    private func metricBar(_ height: Double, color: Color, label: String) -> some View {
        Rectangle()
            .fill(color.opacity(0.7))
            .frame(width: 36, height: height)
            .border(.primary)
            .accessibilityLabel(Text(label))
    }

    private static func baseSize(for style: Font.TextStyle) -> Double {
        #if os(Android)
        // TODO compute these in a @Composable somehow? But it makes the test too complex
        switch style {
        case .largeTitle: return 32.0
        case .title: return 26.0
        case .title2: return 20.0
        case .title3: return 18.0
        case .headline: return 16.0
        case .subheadline: return 14.0
        case .body: return 16.0
        case .callout: return 15.0
        case .footnote: return 12.0
        case .caption: return 11.25
        case .caption2: return 11.0
        @unknown default: return 16.0
        }
        #elseif canImport(UIKit)
        let font = UIFont.preferredFont(forTextStyle: uiTextStyle(for: style))
        return Double(font.pointSize)
        #elseif canImport(AppKit)
        let font = NSFont.preferredFont(forTextStyle: uiTextStyle(for: style), options: [:])
        return Double(font.pointSize)
        #else
        return hardcodedAppleBaseSize(for: style)
        #endif
    }

    #if canImport(UIKit) || canImport(AppKit)
    private static func uiTextStyle(for style: Font.TextStyle) -> UIFont.TextStyle {
        switch style {
        case .largeTitle: return .largeTitle
        case .title: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .footnote: return .footnote
        case .caption: return .caption1
        case .caption2: return .caption2
        @unknown default: return .body
        }
    }
    #endif

    private static func hardcodedAppleBaseSize(for style: Font.TextStyle) -> Double {
        switch style {
        case .largeTitle: return 34.0
        case .title: return 28.0
        case .title2: return 22.0
        case .title3: return 20.0
        case .headline: return 17.0
        case .subheadline: return 15.0
        case .body: return 17.0
        case .callout: return 16.0
        case .footnote: return 13.0
        case .caption: return 12.0
        case .caption2: return 11.0
        @unknown default: return 17.0
        }
    }
}
