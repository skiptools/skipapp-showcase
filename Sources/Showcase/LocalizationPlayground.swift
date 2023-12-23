// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI
import Foundation

extension Locale {
    /// The title of the language as the current locale language's name for the locale followed by the language name in the language itself. E.g., `French: français`
    var localizedNavigationTitle: String {
        (Locale.current.localizedString(forLanguageCode: identifier) ?? "") + ": " + (localizedString(forLanguageCode: identifier) ?? "")
    }
}

struct LocalizationPlayground: View {
    static let bundleLocalizations: [Locale] = Bundle.module.localizations.map({ Locale(identifier: $0) })

    var body: some View {
        List(Self.bundleLocalizations, id: \.self) { type in
            NavigationLink(type.localizedNavigationTitle, value: type)
        }
        .navigationDestination(for: Locale.self) { locale in
            LocalizationTextView(bundle: Bundle(url: Bundle.module.url(forResource: locale.identifier, withExtension: "lproj")!))
                .navigationTitle(locale.localizedNavigationTitle)
                #if !SKIP
                .environment(\.locale, locale)
                .environment(\.layoutDirection, locale.language.lineLayoutDirection == .rightToLeft ? .rightToLeft : .leftToRight)
                #endif
        }
    }
}

private class BundleMarkerClass {
}

struct LocalizationTextView: View {
    /// The localization bundle for this view
    let bundle: Bundle?

    #if !SKIP
    @Environment(\.locale) var locale
    #endif

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(verbatim: "Localized “Done”:")

                //Text("Done")
                //Text("Done", bundle: Bundle.module)
                Text(LocalizedStringKey("Done"), bundle: bundle, comment: "Done button text")
            }

            Divider()

            #if !SKIP
            HStack {
                Text(verbatim: "LocalizedStringResource “Done”:")

                //Text("Done")
                //Text("Done", bundle: bundle)
                let resource = LocalizedStringResource("Done", table: nil, locale: locale, bundle: LocalizedStringResource.BundleDescription.forClass(BundleMarkerClass.self), comment: "Done button text")
                Text(resource)
            }

            Divider()
            #endif

            HStack {
                Text(verbatim: "Localized “String: %@ Number: %.2d”:")
                Text(LocalizedStringKey("String: \("ABC") Number: \(1.234)"), bundle: bundle)
                //Text(String(format: "String: %@ Number: %d", "ABC", 1.234), bundle: bundle)
            }

            Divider()

            HStack {
                Text(verbatim: "Localized multi-line:")
                Text(LocalizedStringKey("""
                Multi-Line 1
                Multi-Line **2**
                Multi-Line "3"
                """), bundle: bundle, comment: "multi-line text")
            }

            Spacer()
        }
        .padding()
    }
}
