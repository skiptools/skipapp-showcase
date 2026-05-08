// Copyright 2023–2025 Skip
import XCTest

@MainActor
final class NavigationStackPlaygroundUITests: XCTestCase, Sendable {
    private var app: XCUIApplication!

    override func setUp() async throws {
        try await super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-UITestingResetShowcaseSearch")
        app.launch()
    }

    func testNavigationStackPlaygroundShowsPopButton() throws {
        app.tabBars.buttons["Showcase"].tap()

        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5), "Search field should appear on Showcase tab")
        searchField.tap()
        searchField.typeText("NavigationStack")

        let row = app.staticTexts["NavigationStack"]
        XCTAssertTrue(row.waitForExistence(timeout: 5), "Filtered list should include NavigationStack")
        row.tap()

        XCTAssertTrue(app.buttons["Pop"].waitForExistence(timeout: 5), "NavigationStack playground should show Pop button")
    }
}
