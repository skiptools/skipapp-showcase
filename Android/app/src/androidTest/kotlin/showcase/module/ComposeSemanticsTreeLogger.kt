package showcase.module

import android.util.Log
import androidx.compose.ui.semantics.SemanticsNode
import androidx.compose.ui.test.isRoot
import androidx.compose.ui.test.junit4.ComposeTestRule

/**
 * Dumps the Compose semantics tree (unmerged) to logcat, matching the style used by navigation-stack tests.
 */
class ComposeSemanticsTreeLogger(
    private val rule: ComposeTestRule,
    private val snapshotInfoTag: String,
    private val treeLineTagPrefix: String,
) {
    private var treeSnapshotCounter = 0

    fun logTree(stage: String) {
        treeSnapshotCounter += 1
        val safeStage = stage.replace(" ", "_")
        Log.i(snapshotInfoTag, "snapshot=$treeSnapshotCounter stage=$safeStage")
        try {
            val tag = "$treeLineTagPrefix$treeSnapshotCounter"
            val roots = rule
                .onAllNodes(isRoot(), useUnmergedTree = true)
                .fetchSemanticsNodes()
            Log.d(tag, "Printing with useUnmergedTree = 'true', roots=${roots.size}")
            roots.forEachIndexed { index, root ->
                Log.d(tag, "Root[$index]:")
                logSemanticsNode(tag, root, depth = 1)
            }
        } catch (t: Throwable) {
            Log.w(snapshotInfoTag, "tree logging unavailable for stage=$safeStage", t)
        }
    }

    private fun logSemanticsNode(tag: String, node: SemanticsNode, depth: Int) {
        val indent = "  ".repeat(depth)
        Log.d(tag, "${indent}Node #${node.id} at ${node.boundsInRoot}")
        if (node.config.toString().isNotBlank()) {
            Log.d(tag, "${indent}config=${node.config}")
        }
        node.children.forEach { child ->
            logSemanticsNode(tag, child, depth + 1)
        }
    }
}
