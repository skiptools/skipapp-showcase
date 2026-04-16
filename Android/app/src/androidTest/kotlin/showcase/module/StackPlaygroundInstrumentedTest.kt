package showcase.module

import android.content.Context
import android.graphics.Bitmap
import android.util.Log
import androidx.compose.ui.graphics.asAndroidBitmap
import androidx.compose.ui.test.hasAnyAncestor
import androidx.compose.ui.test.hasClickAction
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.onRoot
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performTextInput
import androidx.compose.ui.test.captureToImage
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.uiautomator.By
import androidx.test.uiautomator.ResultsReporter
import androidx.test.uiautomator.UiDevice
import androidx.test.uiautomator.Until
import java.io.FileOutputStream
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.rules.RuleChain
import org.junit.rules.TestName
import org.junit.rules.TestWatcher
import org.junit.runner.Description
import org.junit.runner.RunWith

private const val TAB_BAR_TEST_TAG = "skip_ui_automation_tab_bar"
private const val SEARCH_FIELD_TEST_TAG = "skip_ui_automation_search_field"

private const val PLAYGROUND_TITLE = "Showcase"
/** Search query; list row title is "Stacks" (see PlaygroundListView). */
private const val PLAYGROUND_SEARCH_TEXT = "Stack"
private const val PLAYGROUND_ROW_TEXT = "Stacks"

@RunWith(AndroidJUnit4::class)
class StackPlaygroundInstrumentedTest {

    private val composeTestRule = createAndroidComposeRule<MainActivity>()

    private val semanticsTreeLogger by lazy {
        ComposeSemanticsTreeLogger(composeTestRule, "StackPlaygroundTest", "StackPlaygroundTree")
    }

    @get:Rule
    val testName: TestName = TestName()

    private lateinit var resultsReporter: ResultsReporter

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
            Log.e("StackPlaygroundTest", "Failed ${description.methodName}", e)
        }
    }).around(composeTestRule)

    @Before
    fun setupResultsReporter() {
        resultsReporter = ResultsReporter("${javaClass.simpleName}_${testName.methodName}")
    }

    @After
    fun reportAdditionalOutput() {
        if (::resultsReporter.isInitialized) {
            resultsReporter.reportToInstrumentation()
        }
    }

    @Test
    fun openStackPlayground_capturesScreenshot() {
        openStackPlayground()

        composeTestRule.onNodeWithText("Fixed vs Expanding:").assertExists()
        composeTestRule.waitForIdle()

        captureComposeRootPng(
            "stack_playground.png",
            "Stack playground (Compose root)",
        )
    }

    private fun captureComposeRootPng(fileName: String, title: String) {
        composeTestRule.waitForIdle()
        semanticsTreeLogger.logTree("screenshot_${fileName.substringBeforeLast('.')}")
        val bitmap = composeTestRule.onRoot().captureToImage().asAndroidBitmap()
        val file = resultsReporter.addNewFile(fileName, title)
        FileOutputStream(file).use { out ->
            check(bitmap.compress(Bitmap.CompressFormat.PNG, 100, out)) { "PNG compress failed" }
        }
    }

    private fun openStackPlayground() {
        val device = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())
        val pkg = composeTestRule.activity.packageName
        device.wait(Until.hasObject(By.pkg(pkg).depth(0)), 5_000)

        composeTestRule.onNode(
            hasText(PLAYGROUND_TITLE, substring = false) and
                hasClickAction() and
                hasAnyAncestor(hasTestTag(TAB_BAR_TEST_TAG)),
        ).performClick()
        composeTestRule.waitForIdle()

        composeTestRule.onNodeWithTag(SEARCH_FIELD_TEST_TAG, useUnmergedTree = true)
            .performTextInput(PLAYGROUND_SEARCH_TEXT)
        composeTestRule.waitForIdle()

        composeTestRule.onNode(
            hasText(PLAYGROUND_ROW_TEXT, substring = false) and
                hasTestTag(SEARCH_FIELD_TEST_TAG).not(),
        ).performClick()
        composeTestRule.waitForIdle()
    }
}
