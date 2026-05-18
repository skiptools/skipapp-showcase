// Copyright 2023–2026 Skip
import SwiftUI

/// All Showcase playgrounds.
enum PlaygroundType: CaseIterable, View {
    case accessibility
    case alert
    case animation
    case audio
    case background
    case blendMode
    case blur
    case border
    case button
    case color
    case colorEffects
    case colorScheme
    case compose
    case contentMargins
    case contextMenu
    case confirmationDialog
    case datePicker
    case disclosureGroup
    case divider
    case documentPicker
    case environment
    case focusState
    case form
    case frame
    case game
    case gesture
    case geometryChange
    case geometryReader
    case gradient
    case graphics
    case grid
    case hapticFeedback
    case icon
    case image
    case keyboard
    case keychain
    case label
    case labeledContent
    case lineSpacing
    case link
    case list
    case localization
    case lottie
    case map
    case mask
    case minimumScaleFactor
    case menu
    case modifier
    case navigationStack
    case notification
    case observable
    case offsetPosition
    case onSubmit
    case overlay
    case pasteboard
    case picker
    case preference
    case progressView
    case redacted
    case safeArea
    case scaledMetric
    case scenePhase
    case scrollView
    case searchable
    case secureField
    case sensors
    case shadow
    case shape
    case shareLink
    case sheet
    case slider
    case spacer
    case sql
    case stack
    case state
    case stepper
    case storage
    case symbol
    case table
    case tabView
    case text
    case textEditor
    case textField
    case toggle
    case toolbar
    case tracking
    case transform
    case timer
    case transition
    case videoPlayer
    case viewThatFits
    case webAuthenticationSession
    case webBrowser
    case webView
    case zIndex

    var title: LocalizedStringResource {
        switch self {
        case .accessibility:
            return LocalizedStringResource("Accessibility", comment: "Title of Accessibility playground")
        case .alert:
            return LocalizedStringResource("Alert", comment: "Title of Alert playground")
        case .animation:
            return LocalizedStringResource("Animation", comment: "Title of Animation playground")
        case .audio:
            return LocalizedStringResource("Audio", comment: "Title of Audio playground")
        case .background:
            return LocalizedStringResource("Background", comment: "Title of Background playground")
        case .blendMode:
            return LocalizedStringResource("BlendMode", comment: "Title of BlendMode playground")
        case .blur:
            return LocalizedStringResource("Blur", comment: "Title of Blur playground")
        case .border:
            return LocalizedStringResource("Border", comment: "Title of Border playground")
        case .button:
            return LocalizedStringResource("Button", comment: "Title of Button playground")
        case .color:
            return LocalizedStringResource("Color", comment: "Title of Color playground")
        case .colorEffects:
            return LocalizedStringResource("Color Effects", comment: "Title of Color Effects playground")
        case .colorScheme:
            return LocalizedStringResource("ColorScheme", comment: "Title of ColorScheme playground")
        case .compose:
            return LocalizedStringResource("Compose", comment: "Title of Compose playground")
        case .contentMargins:
            return LocalizedStringResource("ContentMargins", comment: "Title of ContentMargins playground")
        case .contextMenu:
            return LocalizedStringResource("Context Menu", comment: "Title of Context Menu playground")
        case .confirmationDialog:
            return LocalizedStringResource("ConfirmationDialog", comment: "Title of ConfirmationDialog playground")
        case .datePicker:
            return LocalizedStringResource("DatePicker", comment: "Title of DatePicker playground")
        case .disclosureGroup:
            return LocalizedStringResource("DisclosureGroup", comment: "Title of DisclosureGroup playground")
        case .divider:
            return LocalizedStringResource("Divider", comment: "Title of Divider playground")
        case .documentPicker:
            return LocalizedStringResource("Document and Media Pickers", comment: "Title of Document and Media Pickers playground")
        case .environment:
            return LocalizedStringResource("Environment", comment: "Title of Environment playground")
        case .focusState:
            return LocalizedStringResource("FocusState", comment: "Title of FocusState playground")
        case .form:
            return LocalizedStringResource("Form", comment: "Title of Form playground")
        case .frame:
            return LocalizedStringResource("Frame", comment: "Title of Frame playground")
        case .game:
            return LocalizedStringResource("Game", comment: "Title of Game playground")
        case .geometryChange:
            return LocalizedStringResource("GeometryChange", comment: "Title of GeometryChange playground")
        case .geometryReader:
            return LocalizedStringResource("GeometryReader", comment: "Title of GeometryReader playground")
        case .gesture:
            return LocalizedStringResource("Gesture", comment: "Title of Gesture playground")
        case .gradient:
            return LocalizedStringResource("Gradient", comment: "Title of Gradient playground")
        case .graphics:
            return LocalizedStringResource("Graphics", comment: "Title of Graphics playground")
        case .grid:
            return LocalizedStringResource("Grids", comment: "Title of Grids playground")
        case .hapticFeedback:
            return LocalizedStringResource("Haptick Feedback", comment: "Title of Haptick Feedback playground")
        case .icon:
            return LocalizedStringResource("Icons", comment: "Title of Icons playground")
        case .image:
            return LocalizedStringResource("Image", comment: "Title of Image playground")
        case .keyboard:
            return LocalizedStringResource("Keyboard", comment: "Title of Keyboard playground")
        case .keychain:
            return LocalizedStringResource("Keychain", comment: "Title of Keychain playground")
        case .label:
            return LocalizedStringResource("Label", comment: "Title of Label playground")
        case .labeledContent:
            return LocalizedStringResource("Labeled Content", comment: "Title of Labeled Content playground")
        case .lineSpacing:
            return LocalizedStringResource("Line Spacing", comment: "Title of Line Spacing playground")
        case .link:
            return LocalizedStringResource("Link", comment: "Title of Link playground")
        case .list:
            return LocalizedStringResource("List", comment: "Title of List playground")
        case .localization:
            return LocalizedStringResource("Localization", comment: "Title of Localization playground")
        case .lottie:
            return LocalizedStringResource("Lottie Animation", comment: "Title of Lottie playground")
        case .map:
            return LocalizedStringResource("Map", comment: "Title of Map playground")
        case .mask:
            return LocalizedStringResource("Mask", comment: "Title of Mask playground")
        case .minimumScaleFactor:
            return LocalizedStringResource("MinimumScaleFactor", comment: "Title of MinimumScaleFactor playground")
        case .menu:
            return LocalizedStringResource("Menu", comment: "Title of Menu playground")
        case .modifier:
            return LocalizedStringResource("Modifiers", comment: "Title of Modifiers playground")
        case .navigationStack:
            return LocalizedStringResource("NavigationStack", comment: "Title of NavigationStack playground")
        case .notification:
            return LocalizedStringResource("Notifications", comment: "Title of Notification playground")
        case .observable:
            return LocalizedStringResource("Observable", comment: "Title of Observable playground")
        case .offsetPosition:
            return LocalizedStringResource("Offset/Position", comment: "Title of Offset/Position playground")
        case .onSubmit:
            return LocalizedStringResource("OnSubmit", comment: "Title of OnSubmit playground")
        case .overlay:
            return LocalizedStringResource("Overlay", comment: "Title of Overlay playground")
        case .pasteboard:
            return LocalizedStringResource("Pasteboard", comment: "Title of Pasteboard playground")
        case .picker:
            return LocalizedStringResource("Picker", comment: "Title of Picker playground")
        case .preference:
            return LocalizedStringResource("Preferences", comment: "Title of Preferences playground")
        case .progressView:
            return LocalizedStringResource("ProgressView", comment: "Title of ProgressView playground")
        case .redacted:
            return LocalizedStringResource("Redacted", comment: "Title of Redacted playground")
        case .safeArea:
            return LocalizedStringResource("SafeArea", comment: "Title of SafeArea playground")
        case .scaledMetric:
            return LocalizedStringResource("ScaledMetric", comment: "Title of ScaledMetric playground")
        case .scenePhase:
            return LocalizedStringResource("ScenePhase", comment: "Title of ScenePhase playground")
        case .scrollView:
            return LocalizedStringResource("ScrollView", comment: "Title of ScrollView playground")
        case .searchable:
            return LocalizedStringResource("Searchable", comment: "Title of Searchable playground")
        case .secureField:
            return LocalizedStringResource("SecureField", comment: "Title of SecureField playground")
        case .sensors:
            return LocalizedStringResource("Sensors", comment: "Title of Sensors playground")
        case .shadow:
            return LocalizedStringResource("Shadow", comment: "Title of Shadow playground")
        case .shape:
            return LocalizedStringResource("Shape", comment: "Title of Shape playground")
        case .shareLink:
            return LocalizedStringResource("ShareLink", comment: "Title of ShareLink playground")
        case .sheet:
            return LocalizedStringResource("Sheet", comment: "Title of Sheet playground")
        case .slider:
            return LocalizedStringResource("Slider", comment: "Title of Slider playground")
        case .spacer:
            return LocalizedStringResource("Spacer", comment: "Title of Spacer playground")
        case .sql:
            return LocalizedStringResource("SQL", comment: "Title of SQL playground")
        case .stack:
            return LocalizedStringResource("Stacks", comment: "Title of Stacks playground")
        case .state:
            return LocalizedStringResource("State", comment: "Title of State playground")
        case .stepper:
            return LocalizedStringResource("Stepper", comment: "Title of Stepper playground")
        case .storage:
            return LocalizedStringResource("Storage", comment: "Title of Storage playground")
        case .symbol:
            return LocalizedStringResource("Symbol", comment: "Title of Symbol playground")
        case .table:
            return LocalizedStringResource("Table", comment: "Title of Table playground")
        case .tabView:
            return LocalizedStringResource("TabView", comment: "Title of TabView playground")
        case .text:
            return LocalizedStringResource("Text", comment: "Title of Text playground")
        case .textEditor:
            return LocalizedStringResource("TextEditor", comment: "Title of Text playground")
        case .textField:
            return LocalizedStringResource("TextField", comment: "Title of TextField playground")
        case .timer:
            return LocalizedStringResource("Timer", comment: "Title of Timer playground")
        case .toggle:
            return LocalizedStringResource("Toggle", comment: "Title of Toggle playground")
        case .toolbar:
            return LocalizedStringResource("Toolbar", comment: "Title of Toolbar playground")
        case .tracking:
            return LocalizedStringResource("Tracking", comment: "Title of Tracking playground")
        case .transform:
            return LocalizedStringResource("Transform", comment: "Title of Transform playground")
        case .transition:
            return LocalizedStringResource("Transition", comment: "Title of Transition playground")
        case .videoPlayer:
            return LocalizedStringResource("Video Player", comment: "Title of VideoPlayer playground")
        case .viewThatFits:
            return LocalizedStringResource("ViewThatFits", comment: "Title of ViewThatFits playground")
        case .webAuthenticationSession:
            return LocalizedStringResource("Web Authentication Session", comment: "Title of Web Authentication Session playground")
        case .webBrowser:
            return LocalizedStringResource("WebBrowser", comment: "Title of WebBrowser playground")
        case .webView:
            return LocalizedStringResource("WebView", comment: "Title of WebView playground")
        case .zIndex:
            return LocalizedStringResource("ZIndex", comment: "Title of ZIndex playground")
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
            #if !os(Android) || !SKIP_MODE_FUSE // not yet available in Skip Fuse
            AudioPlayground()
            #else
            Text("AudioPlayground is Lite-only until ported to SkipAV")
            #endif
        case .background:
            BackgroundPlayground()
        case .blendMode:
            BlendModePlayground()
        case .blur:
            BlurPlayground()
        case .border:
            BorderPlayground()
        case .button:
            ButtonPlayground()
        case .color:
            ColorPlayground()
        case .colorEffects:
            ColorEffectsPlayground()
        case .colorScheme:
            ColorSchemePlayground()
        case .compose:
            ComposePlayground()
        case .contentMargins:
            ContentMarginsPlayground()
        case .contextMenu:
            ContextMenuPlayground()
        case .confirmationDialog:
            ConfirmationDialogPlayground()
        case .datePicker:
            DatePickerPlayground()
        case .disclosureGroup:
            DisclosureGroupPlayground()
        case .divider:
            DividerPlayground()
        case .documentPicker:
            DocumentPickerPlayground()
        case .environment:
            EnvironmentPlayground()
        case .focusState:
            FocusStatePlayground()
        case .form:
            FormPlayground()
        case .frame:
            FramePlayground()
        case .game:
            GamePlayground()
        case .geometryChange:
            GeometryChangePlayground()
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
            if #available(iOS 17.0, *) {
                HapticFeedbackPlayground()
            } else {
                Text("Haptic Feedback Unavailable in this OS version")
            }
        case .icon:
            IconPlayground()
        case .image:
            ImagePlayground()
        case .keyboard:
            KeyboardPlayground()
        case .keychain:
            KeychainPlayground()
        case .label:
            LabelPlayground()
        case .labeledContent:
            LabeledContentPlayground()
        case .lineSpacing:
            LineSpacingPlayground()
        case .link:
            LinkPlayground()
        case .list:
            ListPlayground()
        case .localization:
            LocalizationPlayground()
        case .lottie:
            LottiePlayground()
        case .map:
            MapPlayground()
        case .mask:
            MaskPlayground()
        case .minimumScaleFactor:
            MinimumScaleFactorPlayground()
        case .menu:
            MenuPlayground()
        case .modifier:
            ModifierPlayground()
        case .navigationStack:
            NavigationStackPlayground()
        case .notification:
            NotificationPlayground()
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
        case .preference:
            PreferencePlayground()
        case .progressView:
            ProgressViewPlayground()
        case .redacted:
            RedactedPlayground()
        case .safeArea:
            SafeAreaPlayground()
        case .scaledMetric:
            ScaledMetricPlayground()
        case .scenePhase:
            ScenePhasePlayground()
        case .scrollView:
            ScrollViewPlayground()
        case .searchable:
            SearchablePlayground()
        case .secureField:
            SecureFieldPlayground()
        case .sensors:
            SensorsPlayground()
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
        case .sql:
            SQLPlayground()
        case .stack:
            StackPlayground()
        case .state:
            StatePlayground()
        case .stepper:
            StepperPlayground()
        case .storage:
            StoragePlayground()
        case .symbol:
            SymbolPlayground()
        case .table:
            #if !os(Android) || !SKIP_MODE_FUSE // not yet available in Skip Fuse
            TablePlayground()
            #else
            Text("SwiftUI Table is not yet available in SkipFuseUI")
            #endif
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
        case .tracking:
            TrackingPlayground()
        case .transform:
            TransformPlayground()
        case .transition:
            TransitionPlayground()
        case .videoPlayer:
            VideoPlayerPlayground()
        case .viewThatFits:
            ViewThatFitsPlayground()
        case .webAuthenticationSession:
            WebAuthenticationSessionPlayground()
        case .webBrowser:
            WebBrowserPlayground()
        case .webView:
            WebViewPlayground()
        case .zIndex:
            ZIndexPlayground()
        }
    }
}

/// List to navigate to each playground.
public struct PlaygroundNavigationView: View {
    @AppStorage("searchText") var searchText = ""

    public init() {
    }

    public var body: some View {
        NavigationStack {
            List {
                ForEach(matchingPlaygroundTypes, id: \.self) { playground in
                    NavigationLink(value: playground, label: { Text(playground.title) })
                }
            }
            .navigationTitle(Text("Showcase"))
            .navigationDestination(for: PlaygroundType.self) {
                $0.navigationTitle(Text($0.title))
            }
            .searchable(text: $searchText)
        }
    }

    private var matchingPlaygroundTypes: [PlaygroundType] {
        return PlaygroundType.allCases.filter { playground in
            // Filter by search text
            let words = playground.title.key.split(separator: " ")
            let prefix = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            return words.contains { $0.lowercased().starts(with: prefix) }
        }
    }
}


