// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
import OSLog
import SwiftUI

let logger = Logger(subsystem: "playground.app.ui", category: "PlaygroundApp")

enum PlaygroundType: String, CaseIterable {
    case background
    case border
    case button
    case color
    case confirmationDialog
    case divider
    case form
    case frame
    case gesture
    case gradient
    case image
    case label
    case list
    case listControls
    case navigationStack
    case observable
    case offset
    case progressView
    case shape
    case sheet
    case slider
    case spacer
    case stack
    case state
    case symbol
    case tabView
    case text
    case textField
    case toggle
    case toolbar

    var title: String {
        switch self {
        case .background:
            return "Background"
        case .border:
            return "Border"
        case .button:
            return "Button"
        case .color:
            return "Color"
        case .confirmationDialog:
            return "ConfirmationDialog"
        case .divider:
            return "Divider"
        case .form:
            return "Form"
        case .frame:
            return "Frame"
        case .gesture:
            return "Gestures"
        case .gradient:
            return "Gradients"
        case .image:
            return "Image"
        case .label:
            return "Label"
        case .list:
            return "List"
        case .listControls:
            return "List Controls"
        case .navigationStack:
            return "NavigationStack"
        case .observable:
            return "Observable"
        case .offset:
            return "Offset"
        case .progressView:
            return "ProgressView"
        case .shape:
            return "Shape"
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
        case .symbol:
            return "Symbol"
        case .tabView:
            return "TabView"
        case .text:
            return "Text"
        case .textField:
            return "TextField"
        case .toggle:
            return "Toggle"
        case .toolbar:
            return "Toolbar"
        }
    }
}

public struct ContentView: View {
    public init() {
    }
    
    public var body: some View {
        NavigationStack {
            List(PlaygroundType.allCases, id: \.self) { playground in
                NavigationLink(playground.title, value: playground)
            }
            .navigationDestination(for: PlaygroundType.self) {
                switch $0 {
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
                case .confirmationDialog:
                    ConfirmationDialogPlayground()
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
                case .gesture:
                    GesturePlayground()
                        .navigationTitle($0.title)
                case .gradient:
                    GradientPlayground()
                        .navigationTitle($0.title)
                case .image:
                    ImagePlayground()
                        .navigationTitle($0.title)
                case .label:
                    LabelPlayground()
                        .navigationTitle($0.title)
                case .list:
                    ListPlayground()
                        .navigationTitle($0.title)
                case .listControls:
                    ListControlsPlayground()
                        .navigationTitle($0.title)
                case .navigationStack:
                    NavigationStackPlayground()
                        .navigationTitle($0.title)
                case .observable:
                    ObservablePlayground()
                        .navigationTitle($0.title)
                case .offset:
                    OffsetPlayground()
                        .navigationTitle($0.title)
                case .progressView:
                    ProgressViewPlayground()
                        .navigationTitle($0.title)
                case .shape:
                    ShapePlayground()
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
                case .symbol:
                    SymbolPlayground()
                        .navigationTitle($0.title)
                case .tabView:
                    TabViewPlayground()
                        .navigationTitle($0.title)
                case .text:
                    TextPlayground()
                        .navigationTitle($0.title)
                case .textField:
                    TextFieldPlayground()
                        .navigationTitle($0.title)
                case .toggle:
                    TogglePlayground()
                        .navigationTitle($0.title)
                case .toolbar:
                    ToolbarPlayground()
                        .navigationTitle($0.title)
                }
            }
        }
    }
}
