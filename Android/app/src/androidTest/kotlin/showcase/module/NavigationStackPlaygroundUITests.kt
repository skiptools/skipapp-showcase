package showcase.module

import skip.lib.*
import skip.unit.*
import skip.uiautomation.*

@org.junit.runner.RunWith(androidx.test.ext.junit.runners.AndroidJUnit4::class)
class NavigationStackPlaygroundUITests : XCTestCase {
    @Test
    fun testNavigationStackPlaygroundShowsPopButton() {
        val app = XCUIApplication()
        app.launch()

        app.tabBars.buttons["Showcase"].tap()

        val searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout = 5.0), "Search field should appear on Showcase tab")
        searchField.tap()
        searchField.typeText("NavigationStack")

        val row = app.staticTexts["NavigationStack"]
        XCTAssertTrue(row.waitForExistence(timeout = 5.0), "Filtered list should include NavigationStack")
        row.tap()

        XCTAssertTrue(app.buttons["Pop"].waitForExistence(timeout = 5.0), "NavigationStack playground should show Pop button")
    }
}
