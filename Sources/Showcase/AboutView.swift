// Copyright 2023–2025 Skip
import SwiftUI

/// Information and links for Skip and the Showcase app.
struct AboutView: View {
    var body: some View {
        VStack {
            LogoView()
                .padding()

            VStack(spacing: 0) {
                Text("Showcase is a dual-platform app written in Swift and SwiftUI. It demonstrates and exercises Skip's support for various SwiftUI constructs.")
                    .padding()
                LinkDivider()
                Link(destination: URL(string: "https://skip.tools")!) {
                    LinkLabel(text: NSLocalizedString("Skip Technology", bundle: .module, comment: "localized technology title"))
                }
                LinkDivider()
                Link(destination: URL(string: showcaseSourceURLString + "DOWNLOAD.md")!) {
                    LinkLabel(text: "\(appName) \(isAndroid ? "Android" : "iOS") \(isDebugBuild ? "Development" : "Release")")
                }
                LinkDivider()
                Link(destination: URL(string: showcaseSourceURLString)!) {
                    LinkLabel(text: "\(appName) \(appVersion) Source")
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(borderColor)
            }
        }
        .padding()
    }

    struct LogoView : View {
        var body: some View {
            Image("skiplogo", bundle: .module)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
            .padding(20)
            .background(.white) // Fill area outside of image, which has a white background
            .clipShape(Circle())
            .overlay {
                ZStack {
                    Circle()
                        .inset(by: 2)
                        .stroke(Color(red: 68.0 / 255.0, green: 140.0 / 255.0, blue: 206.0 / 255.0), lineWidth: 8)
                    Circle()
                        .inset(by: 2)
                        .stroke(Color(red: 41.0 / 255.0, green: 167.0 / 255.0, blue: 104.0 / 255.0), lineWidth: 4)
                }
            }
        }
    }

    struct LinkLabel : View {
        @Environment(\.layoutDirection) var layoutDirection
        let text: String

        var body: some View {
            HStack {
                Text(text)
                Spacer()
                Image(systemName: layoutDirection == LayoutDirection.rightToLeft ? "arrow.left" : "arrow.forward")
            }
            .padding()
        }
    }

    struct LinkDivider : View {
        var body: some View {
            Rectangle()
                .fill(borderColor)
                .frame(height: 1.0)
                .frame(minWidth: 0.0, maxWidth: .infinity)
        }
    }
}

private let borderColor = Color.primary.opacity(0.2)
