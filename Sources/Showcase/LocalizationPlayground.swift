// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI
import Foundation

struct LocalizationPlayground: View {
    @Environment(\.locale) var currentLocale

    /// The list of available localizations in the current bundle
    static let bundleLocalizations: [Locale] = Bundle.module.localizations.map({ Locale(identifier: $0) })

    var body: some View {
        List(Self.bundleLocalizations.sorted(by: { $0.identifier < $1.identifier }), id: \.self) { type in
            NavigationLink(type.localizedNavigationTitle, value: type)
        }
        .navigationDestination(for: Locale.self) { locale in
            LocalizationPreview().environment(\.locale, locale)
        }
    }
}

struct LocalizationPreview: View {
    @Environment(\.locale) var currentLocale
    @State var date = Date.now

    func formatter(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> DateFormatter {
        let fmt = DateFormatter()
        fmt.dateStyle = dateStyle
        fmt.timeStyle = timeStyle
        fmt.locale = self.currentLocale
        return fmt
    }

    var body: some View {
        VStack {
            Text("Welcome", bundle: .module)
                .font(.largeTitle)
            Text(verbatim: currentLocale.localizedString(forLanguageCode: currentLocale.language.languageCode?.identifier ?? currentLocale.identifier) ?? "")
                .font(.title)
            Text(verbatim: currentLocale.localizedString(forRegionCode: currentLocale.region?.identifier ?? currentLocale.identifier) ?? "")
                .font(.title2)
            Text(verbatim: currentLocale.localizedString(forScriptCode: currentLocale.language.script?.identifier ?? currentLocale.identifier) ?? "")
                .font(.title2)

            Divider()

            Text(verbatim: formatter(dateStyle: .full, timeStyle: .short).string(from: date))
            Text(verbatim: formatter(dateStyle: .none, timeStyle: .full).string(from: date))

            Text(verbatim: formatter(dateStyle: .long, timeStyle: .none).string(from: date))
            Text(verbatim: formatter(dateStyle: .none, timeStyle: .long).string(from: date))

            Text(verbatim: formatter(dateStyle: .medium, timeStyle: .none).string(from: date))
            Text(verbatim: formatter(dateStyle: .none, timeStyle: .medium).string(from: date))

            Text(verbatim: formatter(dateStyle: .short, timeStyle: .none).string(from: date))
            Text(verbatim: formatter(dateStyle: .none, timeStyle: .short).string(from: date))

            DatePicker("", selection: $date)
        }
        .navigationTitle(currentLocale.localizedString(forIdentifier: currentLocale.identifier) ?? "???")
    }
}

extension Locale {
    /// The title of the language as the current locale language's name for the locale followed by the language name in the language itself. E.g., `French: français`
    var localizedNavigationTitle: String {
        (Locale.current.localizedString(forIdentifier: identifier) ?? "") + ": " + (localizedString(forIdentifier: identifier) ?? "")
    }
}
