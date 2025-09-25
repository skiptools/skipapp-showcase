// Copyright 2023–2025 Skip
import Foundation
import SwiftUI
import SkipMotion

/// This component uses the `SkipMotion` module from https://source.skip.tools/skip-motion
struct LottiePlayground: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(lottieFiles, id: \.name) { lottie in
                    MotionView(lottie: lottie.container)
                        .frame(height: 100.0)
                }
            }
            .padding()
        }
    }
}

let lottieFiles: [(name: String, container: LottieContainer)] = [
    "lottie-loader-01.json",
    "lottie-loader-02.json",
    "lottie-loader-03.json",
    "lottie-loader-04.json",
    "lottie-loader-05.json",
    "lottie-loader-06.json",
    "lottie-loader-07.json",
    "lottie-loader-08.json",
    "lottie-loader-09.json",
    "lottie-loader-10.json",
    "lottie-loader-11.json",
    "lottie-loader-12.json",
    "lottie-loader-13.json",
    "lottie-loader-14.json",
    "lottie-loader-15.json",
    "lottie-loader-16.json",
    "lottie-loader-17.json",
    "lottie-loader-18.json",
    "lottie-loader-19.json",
    "lottie-loader-20.json",
    "lottie-loader-21.json",
    "lottie-loader-22.json",
].map {
    ($0, try! LottieContainer(data: Data(contentsOf: Bundle.module.url(forResource: $0, withExtension: nil)!)))
}
