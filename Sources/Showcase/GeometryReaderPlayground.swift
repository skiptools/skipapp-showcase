// Copyright 2023–2025 Skip
import SwiftUI

struct GeometryReaderPlayground: View {
    var body: some View {
        GeometryReader { rootProxy in
            let _ = logger.info("root safe area insets: \(rootProxy.safeAreaInsets.top), \(rootProxy.safeAreaInsets.leading), \(rootProxy.safeAreaInsets.bottom), \(rootProxy.safeAreaInsets.trailing)")
            ScrollView {
                VStack(spacing: 16) {
                    Text("Size").bold()
                    GeometryReader { proxy in
                        HStack(spacing: 0) {
                            Text("1/3")
                                .font(.largeTitle)
                                .frame(width: proxy.size.width * 0.33)
                                .background(.blue)
                            Text("2/3")
                                .font(.largeTitle)
                                .frame(width: proxy.size.width * 0.67)
                                .background(.red)
                        }
                    }
                    .frame(height: 50)
                    Text("Frame").bold()
                    GeometryReader { proxy in
                        let _ = logger.info("sub proxy safe area insets: \(proxy.safeAreaInsets.top), \(proxy.safeAreaInsets.leading), \(proxy.safeAreaInsets.bottom), \(proxy.safeAreaInsets.trailing)")
                        VStack {
                            Text("Local frame: \(string(for: proxy.frame(in: .local)))")
                            Text("Global frame: \(string(for: proxy.frame(in: .global)))")
                        }
                    }
                    .background(.yellow)
                    .padding()
                    .border(.blue)
                    .frame(height: 100)
                    Text("Safe Area Insets").bold()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Top: \(Int(rootProxy.safeAreaInsets.top))")
                        Text("Leading: \(Int(rootProxy.safeAreaInsets.leading))")
                        Text("Bottom: \(Int(rootProxy.safeAreaInsets.bottom))")
                        Text("Trailing: \(Int(rootProxy.safeAreaInsets.trailing))")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .frame(height: 150)
                    NavigationLink("onGeometryChange") {
                        ScrollView(.vertical) {
                            VStack {
                                OnGeometryChangeExample()
                                    .navigationTitle("onGeometryChange")
                                ForEach(1..<100) { i in
                                    Text("Item \(i)")
                                }
                            }
                        }
                    }
                }
                .padding(rootProxy.safeAreaInsets)
            }
            .ignoresSafeArea()
            .border(.green, width: 2)
            .toolbar {
                PlaygroundSourceLink(file: "GeometryReaderPlayground.swift")
            }
        }
    }

    private func string(for rect: CGRect) -> String {
        return "(\(Int(rect.minX)), \(Int(rect.minY)), \(Int(rect.width)), \(Int(rect.height)))"
    }
}

struct OnGeometryChangeExample: View {
    @State private var isWide = false
    @State private var changeCount = 0

    var body: some View {
        let _ = logger.info("OnGeometryChangeExample isWide: \(isWide), changeCount: \(changeCount)")
        if #available(iOS 18.0, *) {
            Text("Is wide: \(isWide ? "Yes" : "No"), changes: \(changeCount)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .frame(minHeight: 80)
                .background(Color.yellow.opacity(0.3))
                .onGeometryChange(for: Bool.self) { proxy in
                    logger.info("OnGeometryChangeExample proxy.size.width: \(proxy.size.width)")
                    return proxy.size.width > 450
                } action: { old, new in
                    logger.info("OnGeometryChangeExample old: \(old), new: \(new)")
                    isWide = new
                    changeCount += 1
                }
        } else {
            Text("Is wide: \(isWide ? "Yes" : "No"), changes: \(changeCount)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .frame(minHeight: 80)
                .background(Color.yellow.opacity(0.3))
                .onGeometryChange(for: Bool.self) { proxy in
                    logger.info("OnGeometryChangeExample proxy.size.width: \(proxy.size.width)")
                    return proxy.size.width > 450
                } action: { new in
                    logger.info("OnGeometryChangeExample new: \(new)")
                    isWide = new
                    changeCount += 1
                }
        }
    }
}

