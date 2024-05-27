// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

/// Information and links for Skip and the Showcase app.
struct AboutView: View {
    var body: some View {
        VStack {
            LogoView()
                .padding()

            VStack(spacing: 0) {
                Text("Showcase is a dual-platform iOS + Android app written in Swift and SwiftUI. It demonstrates and exercises Skip's support for various SwiftUI constructs on Android")
                    .padding()
                LinkDivider()
                Link(destination: URL(string: "https://skip.tools")!) {
                    LinkLabel(text: "Skip Technology")
                }
                LinkDivider()
                Link(destination: URL(string: showcaseSourceURLString + "DOWNLOAD.md")!) {
                    #if SKIP
                    LinkLabel(text: "Showcase iOS Version")
                    #else
                    LinkLabel(text: "Showcase Android Version")
                    #endif
                }
                LinkDivider()
                Link(destination: URL(string: showcaseSourceURLString)!) {
                    LinkLabel(text: "Showcase \(appVersion ?? "Unknown") Source")
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
            AsyncImage(url: Bundle.module.url(forResource: "skip-logo", withExtension: "png")) {
                $0.image?.resizable()
            }
            .frame(width: 80, height: 80)
            .padding(20)
            .background(.white) // Fill area outside of image, which has a white background
            .clipShape(Circle())
            .overlay {
                ZStack {
                    Circle()
                        .inset(by: 2)
                        .stroke(.black, lineWidth: 4)
                    Circle()
                        .inset(by: 2)
                        .stroke(Color(red: 1, green: 1, blue: 0), lineWidth: 2) // Match logo pure yellow
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

let appVersion: String? = {
    #if !SKIP
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    #else
    let context = ProcessInfo.processInfo.androidContext
    let packageManager = context.getPackageManager()
    let packageInfo = packageManager.getPackageInfo(context.getPackageName(), android.content.pm.PackageManager.GET_META_DATA)
    let versionName = packageInfo.versionName
    let versionCode = packageInfo.versionCode
    return versionName
    #endif
}()
