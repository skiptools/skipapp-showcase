package showcase.module

import android.util.Log
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.uiautomator.ResultsReporter
import androidx.test.uiautomator.UiDevice
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.rules.RuleChain
import org.junit.rules.TestWatcher
import org.junit.runner.Description
import org.junit.runner.RunWith
import org.junit.runners.Parameterized

/**
 * Screenshot + semantics tree for every Showcase playground listed in [PlaygroundListView] / [ComposeFlexibleRegressionTestPlan.md].
 * Search filtering matches [PlaygroundNavigationView.matchingPlaygroundTypes] (word-prefix match).
 */
@RunWith(Parameterized::class)
class ComposeFlexibleRegressionScreenshotTest(
    private val rowTitle: String,
    private val searchQuery: String,
    @Suppress("unused") private val caseIndex: Int,
) {

    private val composeTestRule = createAndroidComposeRule<MainActivity>()

    private val semanticsTreeLogger by lazy {
        ComposeSemanticsTreeLogger(composeTestRule, "ComposeFlexReg", "ComposeFlexTree")
    }

    private lateinit var resultsReporter: ResultsReporter

    @get:Rule
    val ruleChain: RuleChain = RuleChain.outerRule(object : TestWatcher() {
        override fun starting(description: Description) {
            val ctx = InstrumentationRegistry.getInstrumentation().targetContext
            PlaygroundScreenshotHarness.applyShowcaseTabPrefs(ctx)
            PlaygroundScreenshotHarness.grantShowcaseRuntimePermissions(ctx.packageName)
        }

        override fun failed(e: Throwable?, description: Description) {
            Log.e("ComposeFlexReg", "Failed ${description.methodName} ($rowTitle)", e)
            try {
                repeat(4) {
                    UiDevice.getInstance(InstrumentationRegistry.getInstrumentation()).pressBack()
                    Thread.sleep(150)
                }
            } catch (_: Throwable) {
                // best-effort recovery for the next parameterized case
            }
        }
    }).around(composeTestRule)

    @Before
    fun setupResultsReporter() {
        // Avoid `/`, `[`, `]` in names — Gradle additional-test-output paths must be valid on disk.
        resultsReporter = ResultsReporter("${javaClass.simpleName}_case$caseIndex")
    }

    @After
    fun reportAdditionalOutput() {
        if (::resultsReporter.isInitialized) {
            resultsReporter.reportToInstrumentation()
        }
    }

    @Test
    fun openPlayground_captureScreenshotAndSemantics() {
        PlaygroundScreenshotHarness.openPlaygroundFromList(
            composeTestRule,
            searchQuery,
            rowTitle,
        )
        composeTestRule.waitForIdle()

        val base = PlaygroundScreenshotHarness.safePngBaseName(rowTitle)
        PlaygroundScreenshotHarness.captureComposeRootPng(
            composeTestRule,
            resultsReporter,
            semanticsTreeLogger,
            "$base.png",
            "ComposeFlexible regression: $rowTitle",
        )
    }

    companion object {
        /**
         * Localized titles from [PlaygroundType.title] in [PlaygroundListView.swift] (enum order).
         */
        private val ALL_LOCALIZED_PLAYGROUND_TITLES = listOf(
            "Accessibility",
            "Alert",
            "Animation",
            "Audio",
            "Background",
            "Blur",
            "Border",
            "Button",
            "Color",
            "ColorScheme",
            "Compose",
            "Context Menu",
            "ConfirmationDialog",
            "Content Margins",
            "DatePicker",
            "DisclosureGroup",
            "Divider",
            "DocumentPicker",
            "Environment",
            "FocusState",
            "Form",
            "Frame",
            "GeometryChange",
            "GeometryReader",
            "ViewThatFits",
            "Gestures",
            "Gradients",
            "Graphics",
            "Grids",
            "Haptic Feedback",
            "Icons",
            "Image",
            "Keyboard",
            "Keychain",
            "Link",
            "Label",
            "List",
            "Localization",
            "Lottie Animation",
            "Map",
            "Menu",
            "Modifiers",
            "NavigationStack",
            "Notification",
            "Observable",
            "Offset/Position",
            "OnSubmit",
            "Overlay",
            "Pasteboard",
            "Picker",
            "Preferences",
            "ProgressView",
            "Redacted",
            "SafeArea",
            "ScenePhase",
            "ScrollView",
            "Searchable",
            "SecureField",
            "Shadow",
            "Shape",
            "ShareLink",
            "Sheet",
            "Slider",
            "Spacer",
            "SQL",
            "Stacks",
            "State",
            "Storage",
            "Symbol",
            "Table",
            "TabView",
            "Text",
            "TextEditor",
            "TextField",
            "Timer",
            "Toggle",
            "Toolbar",
            "Transition",
            "Video Player",
            "Web Authentication Session",
            "WebBrowser",
            "WebView",
            "ZIndex",
        )

        @JvmStatic
        @Parameterized.Parameters(name = "case_{2}")
        fun parameters(): Collection<Array<Any>> {
            return ALL_LOCALIZED_PLAYGROUND_TITLES.mapIndexed { index, title ->
                val query = PlaygroundScreenshotHarness.searchPrefixForPlayground(
                    title,
                    ALL_LOCALIZED_PLAYGROUND_TITLES,
                )
                arrayOf<Any>(title, query, index)
            }
        }
    }
}
