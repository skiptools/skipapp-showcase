#if canImport(SkipTest)
import SkipTest

/// This test case will run the transpiled tests for the Skip module.
@available(macOS 13, macCatalyst 16, *)
final class XCSkipTests: XCTestCase, XCGradleHarness {
    public func testSkipModule() async throws {
        #if DEBUG
        try await gradle(actions: ["testDebug"])
        #else
        try await gradle(actions: ["testRelease"])
        #endif
    }
}
#endif
