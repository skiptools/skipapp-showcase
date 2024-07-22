// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import SwiftUI

/// All Showcase playgrounds.
enum PlaygroundType: CaseIterable {
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
    case divider
    case form
    case frame
    case gesture
    case geometryReader
    case gradient
    case grid
    case hapticFeedback
    case icon
    case image
    case keyboard
    case label
    case link
    case list
    case localization
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
    case safeArea
    case scenePhase
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

    var title: String {
        switch self {
        case .accessibility:
            return "Accessibility"
        case .alert:
            return "Alert"
        case .animation:
            return "Animation"
        case .audio:
            return "Audio"
        case .background:
            return "Background"
        case .border:
            return "Border"
        case .button:
            return "Button"
        case .color:
            return "Color"
        case .colorScheme:
            return "ColorScheme"
        case .compose:
            return "Compose"
        case .confirmationDialog:
            return "ConfirmationDialog"
        case .datePicker:
            return "DatePicker"
        case .divider:
            return "Divider"
        case .form:
            return "Form"
        case .frame:
            return "Frame"
        case .geometryReader:
            return "GeometryReader"
        case .gesture:
            return "Gestures"
        case .gradient:
            return "Gradients"
        case .grid:
            return "Grids"
        case .hapticFeedback:
            return "Haptic Feedback"
        case .icon:
            return "Icons"
        case .image:
            return "Image"
        case .keyboard:
            return "Keyboard"
        case .link:
            return "Link"
        case .label:
            return "Label"
        case .list:
            return "List"
        case .localization:
            return "Localization"
        case .menu:
            return "Menu"
        case .modifier:
            return "Modifiers"
        case .navigationStack:
            return "NavigationStack"
        case .observable:
            return "Observable"
        case .offsetPosition:
            return "Offset/Position"
        case .onSubmit:
            return "OnSubmit"
        case .overlay:
            return "Overlay"
        case .pasteboard:
            return "Pasteboard"
        case .picker:
            return "Picker"
        case .progressView:
            return "ProgressView"
        case .safeArea:
            return "SafeArea"
        case .scenePhase:
            return "ScenePhase"
        case .searchable:
            return "Searchable"
        case .secureField:
            return "SecureField"
        case .shadow:
            return "Shadow"
        case .shape:
            return "Shape"
        case .shareLink:
            return "ShareLink"
        case .sheet:
            return "Sheet"
        case .slider:
            return "Slider"
        case .spacer:
            return "Spacer"
        case .stack:
            return "Stacks"
        case .state:
            return "State"
        case .storage:
            return "Storage"
        case .symbol:
            return "Symbol"
        case .table:
            return "Table"
        case .tabView:
            return "TabView"
        case .text:
            return "Text"
        case .textEditor:
            return "TextEditor"
        case .textField:
            return "TextField"
        case .timer:
            return "Timer"
        case .toggle:
            return "Toggle"
        case .toolbar:
            return "Toolbar"
        case .transition:
            return "Transition"
        case .videoPlayer:
            return "Video Player"
        case .zIndex:
            return "ZIndex"
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
                NavigationLink(playground.title, value: playground)
            }
            .navigationTitle(Text("Showcase"))
            .navigationDestination(for: PlaygroundType.self) {
                switch $0 {
                case .accessibility:
                    AccessibilityPlayground()
                        .navigationTitle($0.title)
                case .alert:
                    AlertPlayground()
                        .navigationTitle($0.title)
                case .animation:
                    AnimationPlayground()
                        .navigationTitle($0.title)
                case .audio:
                    AudioPlayground()
                        .navigationTitle($0.title)
                case .background:
                    BackgroundPlayground()
                        .navigationTitle($0.title)
                case .border:
                    BorderPlayground()
                        .navigationTitle($0.title)
                case .button:
                    ButtonPlayground()
                        .navigationTitle($0.title)
                case .color:
                    ColorPlayground()
                        .navigationTitle($0.title)
                case .colorScheme:
                    ColorSchemePlayground()
                        .navigationTitle($0.title)
                case .compose:
                    ComposePlayground()
                        .navigationTitle($0.title)
                case .confirmationDialog:
                    ConfirmationDialogPlayground()
                        .navigationTitle($0.title)
                case .datePicker:
                    DatePickerPlayground()
                        .navigationTitle($0.title)
                case .divider:
                    DividerPlayground()
                        .navigationTitle($0.title)
                case .form:
                    FormPlayground()
                        .navigationTitle($0.title)
                case .frame:
                    FramePlayground()
                        .navigationTitle($0.title)
                case .geometryReader:
                    GeometryReaderPlayground()
                        .navigationTitle($0.title)
                case .gesture:
                    GesturePlayground()
                        .navigationTitle($0.title)
                case .gradient:
                    GradientPlayground()
                        .navigationTitle($0.title)
                case .grid:
                    GridPlayground()
                        .navigationTitle($0.title)
                case .hapticFeedback:
                    HapticFeedbackPlayground()
                        .navigationTitle($0.title)
                case .icon:
                    IconPlayground()
                        .navigationTitle($0.title)
                case .image:
                    ImagePlayground()
                        .navigationTitle($0.title)
                case .keyboard:
                    KeyboardPlayground()
                        .navigationTitle($0.title)
                case .label:
                    LabelPlayground()
                        .navigationTitle($0.title)
                case .link:
                    LinkPlayground()
                        .navigationTitle($0.title)
                case .list:
                    ListPlayground()
                        .navigationTitle($0.title)
                case .localization:
                    LocalizationPlayground()
                        .navigationTitle($0.title)
                case .menu:
                    MenuPlayground()
                        .navigationTitle($0.title)
                case .modifier:
                    ModifierPlayground()
                        .navigationTitle($0.title)
                case .navigationStack:
                    NavigationStackPlayground()
                        .navigationTitle($0.title)
                case .observable:
                    ObservablePlayground()
                        .navigationTitle($0.title)
                case .offsetPosition:
                    OffsetPositionPlayground()
                        .navigationTitle($0.title)
                case .onSubmit:
                    OnSubmitPlayground()
                        .navigationTitle($0.title)
                case .overlay:
                    OverlayPlayground()
                        .navigationTitle($0.title)
                case .pasteboard:
                    PasteboardPlayground()
                        .navigationTitle($0.title)
                case .picker:
                    PickerPlayground()
                        .navigationTitle($0.title)
                case .progressView:
                    ProgressViewPlayground()
                        .navigationTitle($0.title)
                case .safeArea:
                    SafeAreaPlayground()
                        .navigationTitle($0.title)
                case .scenePhase:
                    ScenePhasePlayground()
                        .navigationTitle($0.title)
                case .searchable:
                    SearchablePlayground()
                        .navigationTitle($0.title)
                case .secureField:
                    SecureFieldPlayground()
                        .navigationTitle($0.title)
                case .shadow:
                    ShadowPlayground()
                        .navigationTitle($0.title)
                case .shape:
                    ShapePlayground()
                        .navigationTitle($0.title)
                case .shareLink:
                    ShareLinkPlayground()
                        .navigationTitle($0.title)
                case .sheet:
                    SheetPlayground()
                        .navigationTitle($0.title)
                case .slider:
                    SliderPlayground()
                        .navigationTitle($0.title)
                case .spacer:
                    SpacerPlayground()
                        .navigationTitle($0.title)
                case .stack:
                    StackPlayground()
                        .navigationTitle($0.title)
                case .state:
                    StatePlayground()
                        .navigationTitle($0.title)
                case .storage:
                    StoragePlayground()
                        .navigationTitle($0.title)
                case .symbol:
                    SymbolPlayground()
                        .navigationTitle($0.title)
                case .table:
                    TablePlayground()
                        .navigationTitle($0.title)
                case .tabView:
                    TabViewPlayground()
                        .navigationTitle($0.title)
                case .text:
                    TextPlayground()
                        .navigationTitle($0.title)
                case .textEditor:
                    TextEditorPlayground()
                        .navigationTitle($0.title)
                case .textField:
                    TextFieldPlayground()
                        .navigationTitle($0.title)
                case .timer:
                    TimerPlayground()
                        .navigationTitle($0.title)
                case .toggle:
                    TogglePlayground()
                        .navigationTitle($0.title)
                case .toolbar:
                    ToolbarPlayground()
                        .navigationTitle($0.title)
                case .transition:
                    TransitionPlayground()
                        .navigationTitle($0.title)
                case .videoPlayer:
                    VideoPlayerPlayground()
                        .navigationTitle($0.title)
                case .zIndex:
                    ZIndexPlayground()
                        .navigationTitle($0.title)
                }
            }
        }
        .searchable(text: $searchText)
    }

    private func matchingPlaygroundTypes() -> [PlaygroundType] {
        return PlaygroundType.allCases.filter {
            let words = $0.title.split(separator: " ")
            let prefix = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return words.contains { $0.lowercased().starts(with: prefix) }
        }
    }
}
