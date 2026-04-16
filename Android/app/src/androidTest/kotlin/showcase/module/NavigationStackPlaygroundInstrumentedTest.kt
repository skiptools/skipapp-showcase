package showcase.module
import android.os.SystemClock
import android.content.Context
import android.util.Log
import androidx.compose.ui.test.hasAnyAncestor
import androidx.compose.ui.test.assertCountEquals
import androidx.compose.ui.test.hasClickAction
import androidx.compose.ui.test.hasContentDescription
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performTextInput
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.uiautomator.By
import androidx.test.uiautomator.UiDevice
import androidx.test.uiautomator.Until
import org.junit.Rule
import org.junit.Test
import org.junit.rules.RuleChain
import org.junit.rules.TestWatcher
import org.junit.runner.Description
import org.junit.runner.RunWith

private const val TAB_BAR_TEST_TAG = "skip_ui_automation_tab_bar"
private const val SEARCH_FIELD_TEST_TAG = "skip_ui_automation_search_field"

private const val PLAYGROUND_TITLE = "Showcase"
private const val PLAYGROUND_SEARCH_TEXT = "NavigationStack"
private const val ROOT_POP_BUTTON = "Pop"

private const val NAV_BACK_CONTENT_DESC = "Back"
private const val SHEET_DISMISS_BUTTON = "Dismiss"
private const val PLAYGROUND_PUSHED_TEXT = "Pushed"

@RunWith(AndroidJUnit4::class)
class NavigationStackPlaygroundInstrumentedTest {

    private val composeTestRule = createAndroidComposeRule<MainActivity>()

    private val semanticsTreeLogger by lazy {
        ComposeSemanticsTreeLogger(composeTestRule, "NavStackTest", "NavStackTree")
    }

    @get:Rule
    val ruleChain: RuleChain = RuleChain.outerRule(object : TestWatcher() {
        override fun starting(description: Description) {
            InstrumentationRegistry.getInstrumentation().targetContext
                .getSharedPreferences("defaults", Context.MODE_PRIVATE)
                .edit()
                .putString("tab", "showcase")
                .remove("searchText")
                .commit()
        }

        override fun failed(e: Throwable?, description: Description) {
            Log.e("NavStackTest", "Failed ${description.methodName}", e)
            logTree("failed_${description.methodName}")
        }
    }).around(composeTestRule)

    @Test
    fun openNavigationStackPlayground_showsPopButton() {
        openNavigationStackPlayground()
        composeTestRule.onNodeWithText(ROOT_POP_BUTTON).assertExists()
    }

    @Test
    fun presentWithBinding_presentsAndPopsBack() {
        openNavigationStackPlayground()

        composeTestRule.onNodeWithText("Present with binding").performClick()
        composeTestRule.waitForIdle()

        composeTestRule.onNodeWithText(PLAYGROUND_PUSHED_TEXT).assertExists()
        navigateBackViaToolbar()

        composeTestRule.onNodeWithText(ROOT_POP_BUTTON).assertExists()
        composeTestRule.onNodeWithText(PLAYGROUND_PUSHED_TEXT).assertDoesNotExist()
    }

    @Test
    fun presentWithItemBinding_chainsItemDestinations_andPops() {
        openNavigationStackPlayground()

        composeTestRule.onNodeWithText("Present with item binding").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Item value: 42").assertExists()

        composeTestRule.onNodeWithText("Navigate forward to 43").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Item value: 43").assertExists()

        composeTestRule.onNodeWithText("Navigate back (set nil)").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Item value: 42").assertExists()

        composeTestRule.onNodeWithText("Navigate back (dismiss)").performClick()
        composeTestRule.waitForIdle()

        composeTestRule.onNodeWithText(ROOT_POP_BUTTON).assertExists()
        composeTestRule.onNodeWithText("Item value: 42").assertDoesNotExist()
    }

    @Test
    fun navigationLinks_pushesAndPopsBack() {
        openNavigationStackPlayground()
        waitForNavigationThrottle()

        composeTestRule.onNode(hasText("NavigationLink") and hasClickAction()).performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText(PLAYGROUND_PUSHED_TEXT).assertExists()
        navigateBackViaToolbar()
        composeTestRule.onNodeWithText(ROOT_POP_BUTTON).assertExists()

        composeTestRule.onNode(hasText("NavigationLink .buttonStyle") and hasClickAction()).performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText(PLAYGROUND_PUSHED_TEXT).assertExists()
        navigateBackViaToolbar()
        composeTestRule.onNodeWithText(ROOT_POP_BUTTON).assertExists()
    }

    @Test
    fun pathBindingSheet_mutatesPathAndMaintainsBackStack() {
        openNavigationStackPlayground()
        composeTestRule.onNodeWithText("Path binding sheet").performClick()
        composeTestRule.waitForIdle()

        composeTestRule.onNodeWithText("path.append(1)").assertExists()
        composeTestRule.onNodeWithText("path += [1, 2]").assertExists()
        composeTestRule.onNodeWithText("Navigate back").assertDoesNotExist()

        composeTestRule.onNodeWithText("path.append(1)").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Navigate back").assertExists()
        composeTestRule.onNodeWithText("path.removeLast()").assertExists()

        composeTestRule.onNodeWithText("path.removeLast()").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Navigate back").assertDoesNotExist()

        composeTestRule.onNodeWithText("path += [1, 2]").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("path.removeLast(2)").assertExists()
        composeTestRule.onNodeWithText("path.reverse()").assertExists()
        composeTestRule.onNodeWithText("Path: 1, 2").assertExists()

        composeTestRule.onNodeWithText("path.reverse()").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path: 2, 1").assertExists()

        composeTestRule.onNodeWithText("path.removeLast(2); path.append(3)").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path: 3").assertExists()
        composeTestRule.onNodeWithText("path.removeLast(2)").assertDoesNotExist()

        composeTestRule.onNodeWithText("path.removeLast()").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Navigate back").assertDoesNotExist()

        composeTestRule.onNodeWithText(SHEET_DISMISS_BUTTON).performClick()
        composeTestRule.waitForIdle()

        composeTestRule.onNodeWithText(ROOT_POP_BUTTON).assertExists()
        popBackToShowcaseIfNeeded()
    }

    @Test
    fun pathBindingSheet_withInitialStack_shrinksAndDismisses() {
        openNavigationStackPlayground()
        composeTestRule.onNodeWithText("Path binding sheet with initial stack").performClick()
        composeTestRule.waitForIdle()

        // With an initial non-empty path, the sheet starts on a pushed destination.
        // Root-level toolbar actions like "Dismiss" are not expected yet.
        composeTestRule.onNodeWithText("Path: 1, 2").assertExists()
        composeTestRule.onNodeWithText("Navigate back").assertExists()
        composeTestRule.onNodeWithText("path.removeLast(2)").assertExists()

        composeTestRule.onNodeWithText("path.removeLast()").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path: 1").assertExists()
        composeTestRule.onNodeWithText("path.removeLast(2)").assertDoesNotExist()

        composeTestRule.onNodeWithText("Navigate back").performClick()
        composeTestRule.waitForIdle()

        // After popping the internal nav destination, the sheet should remain open and the path becomes empty.
        composeTestRule.onNodeWithText(SHEET_DISMISS_BUTTON).assertExists()
        composeTestRule.onNodeWithText("Navigate back").assertDoesNotExist()
        composeTestRule.onNodeWithText("path.append(1)").assertExists()

        composeTestRule.onNodeWithText(SHEET_DISMISS_BUTTON).performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText(ROOT_POP_BUTTON).assertExists()
        popBackToShowcaseIfNeeded()
    }

    @Test
    fun navigationPathBindingSheet_mixedTypeBackStackOperations() {
        openNavigationStackPlayground()
        composeTestRule.onNodeWithText("NavigationPath binding sheet").performClick()
        composeTestRule.waitForIdle()

        composeTestRule.onNodeWithText(SHEET_DISMISS_BUTTON).assertExists()
        composeTestRule.onNodeWithText("Path count: 0").assertExists()

        composeTestRule.onNodeWithText("path.append(1)").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path count: 1").assertExists()

        composeTestRule.onNodeWithText("path.append(\"X\")").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Value: X").assertExists()

        composeTestRule.onNodeWithText("path.removeLast()").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path count: 1").assertExists()
        composeTestRule.onNodeWithText("Value: X").assertDoesNotExist()

        composeTestRule.onNodeWithText("Navigate forward").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path count: 2").assertExists()

        composeTestRule.onNodeWithText("Navigate back").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path count: 1").assertExists()

        composeTestRule.onNodeWithText("path += [2, 3]").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path count: 3").assertExists()
        composeTestRule.onNodeWithText("path.removeLast(2)").assertExists()

        composeTestRule.onNodeWithText("path.removeLast(2)").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path count: 1").assertExists()
        composeTestRule.onNodeWithText("path.removeLast(2)").assertDoesNotExist()

        // We are one level deep in the sheet stack (Path count: 1), so pop to the
        // sheet root before trying to use the root-level Dismiss toolbar button.
        composeTestRule.onNodeWithText("Navigate back").performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText("Path count: 0").assertExists()

        logTree("navigationPathBindingSheet_beforeDismissClick")
        composeTestRule.onNodeWithText(SHEET_DISMISS_BUTTON).performClick()
        composeTestRule.waitForIdle()
        composeTestRule.onNodeWithText(ROOT_POP_BUTTON).assertExists()
        popBackToShowcaseIfNeeded()
    }

    private fun openNavigationStackPlayground() {
        logTree("openNavigationStackPlayground_start")
        popBackToShowcaseIfNeeded()

        waitForIdleLogged("openNavigationStackPlayground_initial")
        val device = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())
        val pkg = composeTestRule.activity.packageName
        device.wait(Until.hasObject(By.pkg(pkg).depth(0)), 5_000)
        logTree("openNavigationStackPlayground_afterDeviceWait")

        // Open the Showcase tab inside the bottom Material tab bar.
        clickNodeLogged("open_showcase_tab") {
            composeTestRule.onNode(
                hasText(PLAYGROUND_TITLE, substring = false) and
                    hasClickAction() and
                    hasAnyAncestor(hasTestTag(TAB_BAR_TEST_TAG)),
            ).performClick()
        }
        waitForIdleLogged("openNavigationStackPlayground_afterShowcaseClick")

        // Search for "NavigationStack" and open the corresponding row.
        clickNodeLogged("focus_search_field_input") {
            composeTestRule.onNodeWithTag(SEARCH_FIELD_TEST_TAG, useUnmergedTree = true)
                .performTextInput(PLAYGROUND_SEARCH_TEXT)
        }
        waitForIdleLogged("openNavigationStackPlayground_afterSearchInput")

        // Exclude the search field subtree so we hit the list row, not the typed text in the field.
        clickNodeLogged("open_navigationstack_row") {
            composeTestRule.onNode(
                hasText(PLAYGROUND_SEARCH_TEXT) and hasTestTag(SEARCH_FIELD_TEST_TAG).not(),
            ).performClick()
        }
        waitForIdleLogged("openNavigationStackPlayground_afterRowClick")
        logTree("openNavigationStackPlayground_end")
    }

    private fun navigateBackViaToolbar() {
        val device = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())
        logTree("navigateBackViaToolbar_before")

        // First try the explicit toolbar back icon (stable on this playground).
        try {
            composeTestRule.onNodeWithText(PLAYGROUND_TITLE).assertExists()
            composeTestRule.onNode(hasContentDescription(NAV_BACK_CONTENT_DESC)).performClick()
        } catch (_: Throwable) {
            // Fallback to system back if semantics don't expose the icon description for some reason.
            device.pressBack()
        }

        SystemClock.sleep(250)
        waitForIdleLogged("navigateBackViaToolbar_after")
        logTree("navigateBackViaToolbar_after")
    }

    private fun popBackToShowcaseIfNeeded() {
        logTree("popBackToShowcaseIfNeeded_before")
        try {
            composeTestRule.onNodeWithText(ROOT_POP_BUTTON).performClick()
            waitForIdleLogged("popBackToShowcaseIfNeeded_afterPop")
        } catch (_: Throwable) {
            // Assume we're already on the Showcase list / not in the playground.
            logTree("popBackToShowcaseIfNeeded_noPopNeeded")
        }
        logTree("popBackToShowcaseIfNeeded_after")
    }

    private fun waitForIdleLogged(stage: String) {
        try {
            composeTestRule.waitForIdle()
        } catch (t: Throwable) {
            logTree("waitForIdleFailed_$stage")
            throw t
        }
    }

    private fun clickNodeLogged(stage: String, action: () -> Unit) {
        logTree("beforeClick_$stage")
        try {
            action()
        } catch (t: Throwable) {
            logTree("clickFailed_$stage")
            throw t
        }
        logTree("afterClick_$stage")
    }

    // wait for minimumNavigationInterval in Navigation.swift
    private fun waitForNavigationThrottle() {
        SystemClock.sleep(400)
    }

    private fun logTree(stage: String) {
        semanticsTreeLogger.logTree(stage)
    }
}
