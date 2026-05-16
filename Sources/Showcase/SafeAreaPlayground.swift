// Copyright 2023–2026 Skip
import SwiftUI

enum SafeAreaPlaygroundType: String, CaseIterable {
    case fullscreenContent
    case fullscreenBackground
    case plainList
    case plainListNoNavStack
    case list
    case bottomBar

    var title: String {
        switch self {
        case .fullscreenContent:
            return "Ignore safe area"
        case .fullscreenBackground:
            return "Background ignores safe area"
        case .plainList:
            return "Plain list"
        case .plainListNoNavStack:
            return "Plain list outside nav stack"
        case .list:
            return "List"
        case .bottomBar:
            return "Bottom toolbar"
        }
    }

    var coverId: String {
        rawValue + "Cover"
    }

    var sheetId: String {
        rawValue + "Sheet"
    }
}

struct SafeAreaPlayground: View {
    @State var isCoverPresented = false
    @State var isSheetPresented = false
    @State var isGeometryPaddingSheetPresented = false
    @State var playgroundType: SafeAreaPlaygroundType = .fullscreenContent

    var body: some View {
        List {
            NavigationLink("Background") {
                SafeAreaBackgroundView()
            }
            Section("Fullscreen cover") {
                ForEach(SafeAreaPlaygroundType.allCases, id: \.coverId) { playgroundType in
                    Button(playgroundType.title) {
                        self.playgroundType = playgroundType
                        isCoverPresented = true
                    }
                }
            }
            NavigationLink("Geometry padding") {
                SafeAreaPadded()
            }
            Button("Geometry padding in sheet") {
                isGeometryPaddingSheetPresented = true
            }
            Section("Sheet") {
                ForEach(SafeAreaPlaygroundType.allCases, id: \.sheetId) { playgroundType in
                    Button(playgroundType.title) {
                        self.playgroundType = playgroundType
                        isSheetPresented = true
                    }
                }
            }
        }
        #if os(macOS)
        .sheet(isPresented: $isSheetPresented) {
            playground(for: playgroundType)
        }
        #else
        .sheet(isPresented: $isSheetPresented) {
            playground(for: playgroundType)
        }
        .sheet(isPresented: $isGeometryPaddingSheetPresented) {
            SafeAreaGeometryPaddingSheet()
        }
        .fullScreenCover(isPresented: $isCoverPresented) {
            playground(for: playgroundType)
        }
        #endif
    }

    @ViewBuilder private func playground(for playgroundType: SafeAreaPlaygroundType) -> some View {
        switch playgroundType {
        case .fullscreenContent:
            SafeAreaFullscreenContent()
        case .fullscreenBackground:
            SafeAreaFullscreenBackground()
        case .plainList:
            SafeAreaPlainList()
        case .plainListNoNavStack:
            SafeAreaPlainListNoNavStack()
        case .list:
            SafeAreaList()
        case .bottomBar:
            #if os(macOS)
            SafeAreaList()
            #else
            SafeAreaBottomBar()
            #endif
        }
    }
}

struct SafeAreaBackgroundView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow, ignoresSafeAreaEdges: .all)
    }
}

struct SafeAreaFullscreenContent: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.yellow
            Button("Dimiss") {
                dismiss()
            }
        }
        .border(.blue, width: 20.0)
        .ignoresSafeArea()
    }
}

struct SafeAreaPadded: View {
    @State var navBarVisibility = Visibility.visible
    @State var tabBarVisibility = Visibility.visible
    @State var bottomBarVisibility = Visibility.visible
    @AppStorage("statusBarHidden") var statusBarHidden = false

    @State private var animatedSafeAreaInsets: EdgeInsets? = nil

    var body: some View {
        GeometryReader { proxy in
            let _ = logger.debug("SafeAreaPadded proxy.safeAreaInsets=\(String(describing: proxy.safeAreaInsets)) animatedSafeAreaInsets=\(String(describing: animatedSafeAreaInsets))")
            ScrollView(.vertical) {
                VStack {
                    Toggle("Status bar hidden", isOn: $statusBarHidden)
                    SafeAreaVisibilityControl(name: "Navigation", visibility: $navBarVisibility)
                    SafeAreaVisibilityControl(name: "Tab", visibility: $tabBarVisibility)
                    SafeAreaVisibilityControl(name: "Bottom", visibility: $bottomBarVisibility)
                    ForEach(0..<40) { index in
                        Text("Row: \(index)")
                    }
                    Toggle("Status bar hidden", isOn: $statusBarHidden)
                    SafeAreaVisibilityControl(name: "Navigation", visibility: $navBarVisibility)
                    SafeAreaVisibilityControl(name: "Tab", visibility: $tabBarVisibility)
                    SafeAreaVisibilityControl(name: "Bottom", visibility: $bottomBarVisibility)
                }
                .frame(maxWidth: .infinity)
                .border(.blue)
                .padding(animatedSafeAreaInsets ?? proxy.safeAreaInsets)
            }
            .border(.red)
            .ignoresSafeArea()
            #if !SKIP
            .onChange(of: proxy.safeAreaInsets) { oldValue, newValue in
                // In SwiftUI, safe area insets are updated without animation when the bars change, so we need to animate the padding
                if animatedSafeAreaInsets == nil {
                    animatedSafeAreaInsets = newValue
                } else if oldValue == newValue {
                    animatedSafeAreaInsets = newValue
                } else {
                    withAnimation(.default) {
                        animatedSafeAreaInsets = newValue
                    }
                }
            }
            #endif
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Bottom bar") {}
            }
        }
        .toolbar(navBarVisibility, for: .navigationBar)
        .toolbar(tabBarVisibility, for: .tabBar)
        .toolbar(bottomBarVisibility, for: .bottomBar)
        .animation(.default, value: navBarVisibility)
        .animation(.default, value: tabBarVisibility)
        .animation(.default, value: bottomBarVisibility)
    }
}

struct SafeAreaGeometryPaddingSheet: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTab = "Geometry"

    var body: some View {
        NavigationStack {
            #if os(macOS)
            SafeAreaPadded()
                .navigationTitle("Geometry padding in sheet")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Dismiss") {
                            dismiss()
                        }
                    }
                }
            #else
            TabView(selection: $selectedTab) {
                SafeAreaPadded()
                    .tabItem { Label("Geometry", systemImage: "ruler") }
                    .tag("Geometry")
                Text("Second tab")
                    .tabItem { Label("Other", systemImage: "circle") }
                    .tag("Other")
            }
            .navigationTitle("Geometry padding in sheet")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
            #endif
        }
    }
}

struct SafeAreaVisibilityControl: View {
    let name: String
    @Binding var visibility: Visibility

    var body: some View {
        if visibility == .hidden {
            Button("Show \(name) Bar") {
                logger.debug("SafeAreaVisibilityControl show \(name) Bar")
                visibility = .visible
            }
        } else {
            Button("Hide \(name) Bar") {
                logger.debug("SafeAreaVisibilityControl hide \(name) Bar")
                visibility = .hidden
            }
        }
    }
}

struct SafeAreaFullscreenBackground: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            Button("Dimiss") {
                dismiss()
            }
        }
        .border(.blue, width: 20.0)
    }
}

struct SafeAreaPlainList: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List(0..<40) { index in
                Text("Row: \(index)")
            }
            .listStyle(.plain)
            .navigationTitle(SafeAreaPlaygroundType.plainList.title)
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

struct SafeAreaPlainListNoNavStack: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        List {
            Button("Dismiss") { dismiss() }
            ForEach(0..<40) { index in
                Text("Row: \(index)")
            }
        }
        .listStyle(.plain)
    }
}

struct SafeAreaList: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List(0..<40) { index in
                Text("Row: \(index)")
            }
            .navigationTitle(SafeAreaPlaygroundType.list.title)
            .toolbar {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

#if os(macOS)
#else
struct SafeAreaBottomBar: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List(0..<40) { index in
                Text("Row: \(index)")
            }
            .navigationTitle(SafeAreaPlaygroundType.bottomBar.title)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}
#endif
