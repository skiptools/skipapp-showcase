// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

/// All Showcase playgrounds.
enum PlaygroundType: CaseIterable, View {
    case accessibility
    case alert
    case animation
    case audio
    case background
    case border
    case button
    case color
    case colorScheme
    case compose
    case confirmationDialog
    case datePicker
    case disclosureGroup
    case divider
    case form
    case frame
    case gesture
    case geometryReader
    case gradient
    case graphics
    case grid
    case hapticFeedback
    case icon
    case image
    case keyboard
    case label
    case link
    case list
    case localization
    case map
    case menu
    case modifier
    case navigationStack
    case observable
    case offsetPosition
    case onSubmit
    case overlay
    case pasteboard
    case picker
    case progressView
    case redacted
    case safeArea
    case scenePhase
    case scrollView
    case searchable
    case secureField
    case shadow
    case shape
    case shareLink
    case sheet
    case slider
    case spacer
    case stack
    case state
    case storage
    case symbol
    case table
    case tabView
    case text
    case textEditor
    case textField
    case toggle
    case toolbar
    case timer
    case transition
    case videoPlayer
    case zIndex

    var title: LocalizedStringResource {
        switch self {
        case .accessibility:
            return LocalizedStringResource("Accessibility")
        case .alert:
            return LocalizedStringResource("Alert")
        case .animation:
            return LocalizedStringResource("Animation")
        case .audio:
            return LocalizedStringResource("Audio")
        case .background:
            return LocalizedStringResource("Background")
        case .border:
            return LocalizedStringResource("Border")
        case .button:
            return LocalizedStringResource("Button")
        case .color:
            return LocalizedStringResource("Color")
        case .colorScheme:
            return LocalizedStringResource("ColorScheme")
        case .compose:
            return LocalizedStringResource("Compose")
        case .confirmationDialog:
            return LocalizedStringResource("ConfirmationDialog")
        case .datePicker:
            return LocalizedStringResource("DatePicker")
        case .disclosureGroup:
            return LocalizedStringResource("DisclosureGroup")
        case .divider:
            return LocalizedStringResource("Divider")
        case .form:
            return LocalizedStringResource("Form")
        case .frame:
            return LocalizedStringResource("Frame")
        case .geometryReader:
            return LocalizedStringResource("GeometryReader")
        case .gesture:
            return LocalizedStringResource("Gestures")
        case .gradient:
            return LocalizedStringResource("Gradients")
        case .graphics:
            return LocalizedStringResource("Graphics")
        case .grid:
            return LocalizedStringResource("Grids")
        case .hapticFeedback:
            return LocalizedStringResource("Haptic Feedback")
        case .icon:
            return LocalizedStringResource("Icons")
        case .image:
            return LocalizedStringResource("Image")
        case .keyboard:
            return LocalizedStringResource("Keyboard")
        case .link:
            return LocalizedStringResource("Link")
        case .label:
            return LocalizedStringResource("Label")
        case .list:
            return LocalizedStringResource("List")
        case .localization:
            return LocalizedStringResource("Localization")
        case .map:
            return LocalizedStringResource("Map")
        case .menu:
            return LocalizedStringResource("Menu")
        case .modifier:
            return LocalizedStringResource("Modifiers")
        case .navigationStack:
            return LocalizedStringResource("NavigationStack")
        case .observable:
            return LocalizedStringResource("Observable")
        case .offsetPosition:
            return LocalizedStringResource("Offset/Position")
        case .onSubmit:
            return LocalizedStringResource("OnSubmit")
        case .overlay:
            return LocalizedStringResource("Overlay")
        case .pasteboard:
            return LocalizedStringResource("Pasteboard")
        case .picker:
            return LocalizedStringResource("Picker")
        case .progressView:
            return LocalizedStringResource("ProgressView")
        case .redacted:
            return LocalizedStringResource("Redacted")
        case .safeArea:
            return LocalizedStringResource("SafeArea")
        case .scenePhase:
            return LocalizedStringResource("ScenePhase")
        case .scrollView:
            return LocalizedStringResource("ScrollView")
        case .searchable:
            return LocalizedStringResource("Searchable")
        case .secureField:
            return LocalizedStringResource("SecureField")
        case .shadow:
            return LocalizedStringResource("Shadow")
        case .shape:
            return LocalizedStringResource("Shape")
        case .shareLink:
            return LocalizedStringResource("ShareLink")
        case .sheet:
            return LocalizedStringResource("Sheet")
        case .slider:
            return LocalizedStringResource("Slider")
        case .spacer:
            return LocalizedStringResource("Spacer")
        case .stack:
            return LocalizedStringResource("Stacks")
        case .state:
            return LocalizedStringResource("State")
        case .storage:
            return LocalizedStringResource("Storage")
        case .symbol:
            return LocalizedStringResource("Symbol")
        case .table:
            return LocalizedStringResource("Table")
        case .tabView:
            return LocalizedStringResource("TabView")
        case .text:
            return LocalizedStringResource("Text")
        case .textEditor:
            return LocalizedStringResource("TextEditor")
        case .textField:
            return LocalizedStringResource("TextField")
        case .timer:
            return LocalizedStringResource("Timer")
        case .toggle:
            return LocalizedStringResource("Toggle")
        case .toolbar:
            return LocalizedStringResource("Toolbar")
        case .transition:
            return LocalizedStringResource("Transition")
        case .videoPlayer:
            return LocalizedStringResource("Video Player")
        case .zIndex:
            return LocalizedStringResource("ZIndex")
        }
    }

    var body: some View {
        switch self {
        case .accessibility:
            AccessibilityPlayground()
        case .alert:
            AlertPlayground()
        case .animation:
            AnimationPlayground()
        case .audio:
            AudioPlayground()
        case .background:
            BackgroundPlayground()
        case .border:
            BorderPlayground()
        case .button:
            ButtonPlayground()
        case .color:
            ColorPlayground()
        case .colorScheme:
            ColorSchemePlayground()
        case .compose:
            ComposePlayground()
        case .confirmationDialog:
            ConfirmationDialogPlayground()
        case .datePicker:
            DatePickerPlayground()
        case .disclosureGroup:
            DisclosureGroupPlayground()
        case .divider:
            DividerPlayground()
        case .form:
            FormPlayground()
        case .frame:
            FramePlayground()
        case .geometryReader:
            GeometryReaderPlayground()
        case .gesture:
            GesturePlayground()
        case .gradient:
            GradientPlayground()
        case .graphics:
            GraphicsPlayground()
        case .grid:
            GridPlayground()
        case .hapticFeedback:
            HapticFeedbackPlayground()
        case .icon:
            IconPlayground()
        case .image:
            ImagePlayground()
        case .keyboard:
            KeyboardPlayground()
        case .label:
            LabelPlayground()
        case .link:
            LinkPlayground()
        case .list:
            ListPlayground()
        case .localization:
            LocalizationPlayground()
        case .map:
            MapPlayground()
        case .menu:
            MenuPlayground()
        case .modifier:
            ModifierPlayground()
        case .navigationStack:
            NavigationStackPlayground()
        case .observable:
            ObservablePlayground()
        case .offsetPosition:
            OffsetPositionPlayground()
        case .onSubmit:
            OnSubmitPlayground()
        case .overlay:
            OverlayPlayground()
        case .pasteboard:
            PasteboardPlayground()
        case .picker:
            PickerPlayground()
        case .progressView:
            ProgressViewPlayground()
        case .redacted:
            RedactedPlayground()
        case .safeArea:
            SafeAreaPlayground()
        case .scenePhase:
            ScenePhasePlayground()
        case .scrollView:
            ScrollViewPlayground()
        case .searchable:
            SearchablePlayground()
        case .secureField:
            SecureFieldPlayground()
        case .shadow:
            ShadowPlayground()
        case .shape:
            ShapePlayground()
        case .shareLink:
            ShareLinkPlayground()
        case .sheet:
            SheetPlayground()
        case .slider:
            SliderPlayground()
        case .spacer:
            SpacerPlayground()
        case .stack:
            StackPlayground()
        case .state:
            StatePlayground()
        case .storage:
            StoragePlayground()
        case .symbol:
            SymbolPlayground()
        case .table:
            TablePlayground()
        case .tabView:
            TabViewPlayground()
        case .text:
            TextPlayground()
        case .textEditor:
            TextEditorPlayground()
        case .textField:
            TextFieldPlayground()
        case .timer:
            TimerPlayground()
        case .toggle:
            TogglePlayground()
        case .toolbar:
            ToolbarPlayground()
        case .transition:
            TransitionPlayground()
        case .videoPlayer:
            VideoPlayerPlayground()
        case .zIndex:
            ZIndexPlayground()
        }
    }
}

/// List to navigate to each playground.
public struct PlaygroundNavigationView: View {
    @State var searchText = ""

    public init() {
    }

    public var body: some View {
        NavigationStack {
            List(matchingPlaygroundTypes(), id: \.self) { playground in
                NavigationLink(value: playground, label: { Text(playground.title) })
            }
            .navigationTitle(Text("Showcase"))
            .navigationDestination(for: PlaygroundType.self) {
                $0.navigationTitle(Text($0.title))
            }
        }
        .searchable(text: $searchText)
    }

    private func matchingPlaygroundTypes() -> [PlaygroundType] {
        return PlaygroundType.allCases.filter {
            let words = String(localized: $0.title).split(separator: " ")
            let prefix = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return words.contains { $0.lowercased().starts(with: prefix) }
        }
    }
}
