// Copyright 2023–2026 Skip
import SwiftUI
import Foundation

struct LocalizationPlayground: View {
    @Environment(\.locale) var currentLocale

    /// The list of available localizations in the current bundle.
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
    private var calendar: Calendar {
        var result = Calendar(identifier: .gregorian)
        result.locale = Locale(identifier: currentLocale.identifier)
        return result
    }

    let skipper = "Skipper"

    func formatter(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> DateFormatter {
        let fmt = DateFormatter()
        fmt.dateStyle = dateStyle
        fmt.timeStyle = timeStyle
        fmt.locale = self.currentLocale
        return fmt
    }

    var body: some View {
        ScrollView {
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                Text(LocalizedStringResource("Welcome"))
                    .font(.title)
                Text("Welcome \(skipper)")
                    .font(.largeTitle)
                Text(LocalizedStringResource("Welcome \(skipper)"))
                    .font(.title)

                Divider()

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

                Divider()

                let pluralizationCounts = [0, 1, 2]
                ForEach(pluralizationCounts, id: \.self) { numberOfDays in
                    Text(String.localizedStringWithFormat(
                        forKey: "repeats_every_day",
                        locale: currentLocale,
                        numberOfDays
                    ))
                    .font(.body)
                }

                Divider()

                let monthSymbols = calendar.shortMonthSymbols
                let monthSymbolsToUse = monthSymbols.enumerated().filter { $0.offset % 2 == 0 }.map { $0.element }.prefix(3)
                let monthSymbolsString = monthSymbolsToUse.joined(separator: ", ")

                ForEach(pluralizationCounts, id: \.self) { numberOfYears in
                    Text(String.localizedStringWithFormat(
                        forKey: "repeats_every_year_in",
                        locale: currentLocale,
                        numberOfYears,
                        monthSymbolsString
                    ))
                    .font(.body)
                }
            }
        }
        .navigationTitle(currentLocale.localizedString(forIdentifier: currentLocale.identifier) ?? "???")
    }
}

extension Locale {

    /// The title of the language as the current locale language's name for the locale followed by the language name in the language itself. E.g., `French: français`.
    var localizedNavigationTitle: String {
        (Locale.current.localizedString(forIdentifier: identifier) ?? "") + ": " + (localizedString(forIdentifier: identifier) ?? "")
    }
}

#if SKIP || SKIP_MODE_FUSE
typealias LocalizationFormatArgument = Any
#else
typealias LocalizationFormatArgument = CVarArg
#endif

extension String {

    /// Formats localized strings, including pluralized entries from string catalogs.
    ///
    /// - Note: String catalog plural rules are exported for Android as ICU MessageFormat
    ///   patterns, for example `{0, plural, one {...} other {...}}`. These patterns
    ///   must be evaluated to select the correct plural branch and substitute arguments.
    ///
    ///   Skip Lite automatically evaluates them through Skip Foundation's `String.localizedStringWithFormat` function.
    ///   Skip Fuse, however, uses the native Swift Foundation implementation, which does not evaluate ICU MessageFormat patterns,
    ///   so our custom `StringFormatter` evaluates them manually using Android's `MessageFormat`.
    static func localizedStringWithFormat(forKey key: String, locale: Locale? = nil, _ arguments: LocalizationFormatArgument...) -> String {
        #if SKIP_MODE_FUSE
        /// Skip Fuse
        let localeIdentifier = (locale ?? .current).identifier
        let formatString = StringFormatter.localizedFormatString(forKey: key, localeIdentifier: localeIdentifier)
        return StringFormatter.localizedStringWithFormat(formatString, localeIdentifier: localeIdentifier, arguments: arguments)
        #elseif SKIP
        /// Skip Lite
        let localizedStringResource = LocalizedStringResource(String.LocalizationValue(key), locale: locale ?? .current)
        let formatString = String(localized: localizedStringResource)
        let list = java.util.ArrayList<Any>()
        for argument in arguments { list.add(argument) }
        return String.localizedStringWithFormat(formatString, *list.toArray())
        #else
        /// Darwin
        let localizedStringResource = LocalizedStringResource(String.LocalizationValue(key), locale: locale ?? .current)
        let formatString = String(localized: localizedStringResource)
        return String.localizedStringWithFormat(formatString, arguments)
        #endif
    }
}

#if SKIP && !SKIP_BRIDGE
/* SKIP @bridge */
public final class StringFormatter: Sendable {

    /* SKIP @bridge */
    public static func localizedFormatString(forKey key: String, localeIdentifier: String) -> String {
        let locale = Locale(identifier: localeIdentifier)
        let (_, localizedFormat, _) = Bundle.main.localizedInfo(forKey: key, value: nil, table: nil, locale: locale)
        return localizedFormat
    }

    /* SKIP @bridge */
    public static func localizedStringWithFormat(_ format: String, localeIdentifier: String, arguments: [Any]) -> String {
        let list = java.util.ArrayList<Any>()
        for argument in arguments { list.add(argument) }

        let platformArguments = list.toArray()
        let platformLocale = java.util.Locale.forLanguageTag(localeIdentifier.replacingOccurrences(of: "_", with: "-"))

        if format.contains("{0, plural,") {
            return android.icu.text.MessageFormat(format, platformLocale).format(platformArguments)
        }

        if !arguments.isEmpty {
            return java.lang.String.format(platformLocale, format, platformArguments)
        }

        return format
    }
}
#endif
