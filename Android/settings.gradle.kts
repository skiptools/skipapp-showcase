// This gradle project is part of a conventional Skip app project.
pluginManagement {
    // Initialize the Skip plugin folder and perform a pre-build for non-Xcode builds
    val pluginPath = File.createTempFile("skip-plugin-path", ".tmp")

    // overriding outputs for an Android IDE can be done by un-commenting and setting the Xcode path:
    //System.setProperty("BUILT_PRODUCTS_DIR", "${System.getProperty("user.home")}/Library/Developer/Xcode/DerivedData/MySkipProject-HASH/Build/Products/Debug-iphonesimulator")
    @Suppress("DEPRECATION")
    exec {
        commandLine("skip", "plugin", "--prebuild", "--package-path", settings.rootDir.parent, "--plugin-ref", pluginPath.absolutePath)
        environment("PATH", "${System.getenv("PATH")}:/opt/homebrew/bin")
    }
    includeBuild(pluginPath.readText()) {
        name = "skip-plugins"
    }
}

plugins {
    id("skip-plugin") apply true
}
