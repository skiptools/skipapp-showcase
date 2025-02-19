// Copyright 2025 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

import SwiftUI
#if !SKIP
import WebKit
#else
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.compose.ui.viewinterop.AndroidView
#endif

struct WebViewPlayground: View {
    var body: some View {
        WebView(url: URL(string: "https://skip.tools")!)
    }
}

// the platform-specific View supertype that is needed to adapt legacy UIKit.UIView/AndroidView to SwiftUI/Compose
#if canImport(UIKit)
typealias ViewAdapter = UIViewRepresentable
#elseif canImport(AppKit)
typealias ViewAdapter = NSViewRepresentable
#else
typealias ViewAdapter = View
#endif

/// This is a very minimal WebView that can be used as an embedded browser view.
/// It has no address bar or navigation buttons.
/// For a more advanced web component, use http://source.skip.tools/skip-web
struct WebView: ViewAdapter {
    let url: URL
    var enableJavaScript: Bool = true

    func update(webView: WebViewType) {
        logger.log("updating web view: \(webView)")
    }

    #if SKIP
    typealias WebViewType = android.webkit.WebView

    // for Android platforms, we take a WebView and wrap it in an AndroidView, which
    // adapts traditional views in a Compose context, and then wrap that in a
    // ComposeView, which integrates it with the SwiftUI view hierarchy
    var body: some View {
        ComposeView { context in
            AndroidView(factory: { ctx in
                let webView = WebView(ctx)
                let client = WebViewClient()
                webView.webViewClient = client
                webView.settings.javaScriptEnabled = enableJavaScript
                webView.setBackgroundColor(0x000000)
                webView.loadUrl(url.absoluteString)
                return webView
            }, modifier: context.modifier, update: update)
        }
    }
    #else
    typealias WebViewType = WKWebView

    // for Darwin platforms, we take a WKWebView and load it using the
    // UIViewRepresentable/NSViewRepresentable system for adapting traditional
    // UIKit views to SwiftUI view hierarchy
    func makeCoordinator() -> WKWebView {
        let webView = WKWebView(frame: .zero)
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = enableJavaScript
        webView.load(URLRequest(url: url))
        return webView
    }

    #if canImport(UIKit)
    func makeUIView(context: Context) -> WKWebView { context.coordinator }
    func updateUIView(_ uiView: WKWebView, context: Context) { update(webView: uiView) }
    #elseif canImport(AppKit)
    func makeNSView(context: Context) -> WKWebView { context.coordinator }
    func updateNSView(_ nsView: WKWebView, context: Context) { update(webView: nsView) }
    #endif
    #endif
}
