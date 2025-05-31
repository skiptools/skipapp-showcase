// Copyright 2023–2025 Skip
import Foundation
import SwiftUI
import SkipMotion

/// This component uses the `SkipMotion` module from https://source.skip.tools/skip-motion
struct LottiePlayground: View {
    static let lottieAnimation = try! LottieContainer(data: Data(contentsOf: Bundle.module.url(forResource: "LottieHeart", withExtension: "json")!))

    var body: some View {
        VStack(alignment: .center) {
            MotionView(lottie: Self.lottieAnimation)
                .frame(height: 250.0)
            Text("an animated heart in the Lottie JSON format")
                .font(.caption)
        }
    }
}
