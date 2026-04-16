package showcase.module

import android.Manifest
import android.content.Context
import android.graphics.Bitmap
import android.os.Build
import androidx.compose.ui.graphics.asAndroidBitmap
import androidx.compose.ui.test.hasAnyAncestor
import androidx.compose.ui.test.hasClickAction
import androidx.compose.ui.test.hasTestTag
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.ComposeTestRule
import androidx.compose.ui.test.onNodeWithTag
import androidx.compose.ui.test.onRoot
import androidx.compose.ui.test.captureToImage
import androidx.compose.ui.test.performClick
import androidx.compose.ui.test.performTextInput
import androidx.test.platform.app.InstrumentationRegistry
import androidx.test.uiautomator.By
import androidx.test.uiautomator.ResultsReporter
import androidx.test.uiautomator.UiDevice
import androidx.test.uiautomator.Until
import java.io.FileOutputStream

object PlaygroundScreenshotHarness {
    const val TAB_BAR_TEST_TAG = "skip_ui_automation_tab_bar"
    const val SEARCH_FIELD_TEST_TAG = "skip_ui_automation_search_field"
    private const val SHOWCASE_TAB_LABEL = "Showcase"

    fun applyShowcaseTabPrefs(context: Context) {
        context.getSharedPreferences("defaults", Context.MODE_PRIVATE)
            .edit()
            .putString("tab", "showcase")
            .remove("searchText")
            .commit()
    }

    /** Pre-grant permissions so playgrounds (Audio, Camera, etc.) do not block on system dialogs. */
    fun grantShowcaseRuntimePermissions(packageName: String) {
        val ui = InstrumentationRegistry.getInstrumentation().uiAutomation
        val perms = buildList {
            add(Manifest.permission.RECORD_AUDIO)
            add(Manifest.permission.CAMERA)
            if (Build.VERSION.SDK_INT >= 33) {
                add(Manifest.permission.POST_NOTIFICATIONS)
            }
        }
        for (perm in perms) {
            try {
                ui.grantRuntimePermission(packageName, perm)
            } catch (_: Throwable) {
                // Ignore unknown or already-granted permissions.
            }
        }
    }

    /**
     * Mirrors [PlaygroundNavigationView.matchingPlaygroundTypes]: any word in the title starts with [prefix] (case-insensitive).
     */
    fun titleMatchesSearchPrefix(title: String, prefix: String): Boolean {
        val p = prefix.lowercase().trim()
        if (p.isEmpty()) return true
        return title.split(" ").any { word ->
            word.isNotEmpty() && word.lowercase().startsWith(p)
        }
    }

    /**
     * Shortest prefix of a word in [title] so the in-app filter is reasonably narrow.
     * Uniqueness is not required (e.g. "Animation" and "Lottie Animation" both match "Anim");
     * the row tap uses [title] with an exact text match.
     */
    fun searchPrefixForPlayground(title: String, allTitles: List<String>, maxMatches: Int = 12): String {
        for (word in title.split(" ")) {
            if (word.isEmpty()) continue
            for (len in 1..word.length) {
                val prefix = word.substring(0, len)
                if (!titleMatchesSearchPrefix(title, prefix)) continue
                val n = allTitles.count { t -> titleMatchesSearchPrefix(t, prefix) }
                if (n <= maxMatches) return prefix
            }
        }
        val first = title.split(" ").firstOrNull { it.isNotEmpty() } ?: return title
        return first
    }

    fun openPlaygroundFromList(
        rule: ComposeTestRule,
        searchQuery: String,
        rowExactTitle: String,
    ) {
        val device = UiDevice.getInstance(InstrumentationRegistry.getInstrumentation())
        val pkg = InstrumentationRegistry.getInstrumentation().targetContext.packageName
        device.wait(Until.hasObject(By.pkg(pkg).depth(0)), 5_000)

        rule.onNode(
            hasText(SHOWCASE_TAB_LABEL, substring = false) and
                hasClickAction() and
                hasAnyAncestor(hasTestTag(TAB_BAR_TEST_TAG)),
        ).performClick()
        rule.waitForIdle()

        rule.onNodeWithTag(SEARCH_FIELD_TEST_TAG, useUnmergedTree = true)
            .performTextInput(searchQuery)
        rule.waitForIdle()

        rule.onNode(
            hasText(rowExactTitle, substring = false) and
                hasTestTag(SEARCH_FIELD_TEST_TAG).not(),
        ).performClick()
        rule.waitForIdle()
        Thread.sleep(400)
    }

    fun captureComposeRootPng(
        rule: ComposeTestRule,
        resultsReporter: ResultsReporter,
        semanticsTreeLogger: ComposeSemanticsTreeLogger,
        fileName: String,
        title: String,
    ) {
        rule.waitForIdle()
        semanticsTreeLogger.logTree("screenshot_${fileName.substringBeforeLast('.')}")
        val bitmap = rule.onRoot().captureToImage().asAndroidBitmap()
        val file = resultsReporter.addNewFile(fileName, title)
        FileOutputStream(file).use { out ->
            check(bitmap.compress(Bitmap.CompressFormat.PNG, 100, out)) { "PNG compress failed" }
        }
    }

    fun safePngBaseName(displayTitle: String): String =
        "regression_" + displayTitle.replace(Regex("[^a-zA-Z0-9]+"), "_").trim('_').lowercase()
}
