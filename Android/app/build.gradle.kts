plugins {
    kotlin("android") version "1.9.0"
    id("com.android.application") version "8.1.0"
}

android {
    defaultConfig {
        minSdk = 29
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        manifestPlaceholders["PRODUCT_NAME"] = prop("PRODUCT_NAME")
        manifestPlaceholders["PRODUCT_BUNDLE_IDENTIFIER"] = prop("PRODUCT_BUNDLE_IDENTIFIER")
        manifestPlaceholders["MARKETING_VERSION"] = prop("MARKETING_VERSION")
        manifestPlaceholders["CURRENT_PROJECT_VERSION"] = prop("CURRENT_PROJECT_VERSION")
        manifestPlaceholders["ANDROID_PACKAGE_NAME"] = prop("ANDROID_PACKAGE_NAME")
        applicationId = manifestPlaceholders["PRODUCT_BUNDLE_IDENTIFIER"]?.toString()
        versionCode = (manifestPlaceholders["CURRENT_PROJECT_VERSION"]?.toString())?.toInt()
        versionName = manifestPlaceholders["MARKETING_VERSION"]?.toString()
    }
    buildFeatures {
        buildConfig = true
        compose = true
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.findByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            isDebuggable = true
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
    }
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.1"
    }
    namespace = group as String
    compileSdk = 34
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    testOptions {
        unitTests {
            isIncludeAndroidResources = true
        }
    }
}

afterEvaluate {
    dependencies {
        // SKIP_DEPENDENCIES is set by the settings.gradle.kts as a list of the modules that were created as a result of the Skip build
        var deps = prop(key = "DEPENDENCIES")
        deps.split(":").filter { it.isNotEmpty() }.forEach { skipModuleName ->
            if (skipModuleName != "SkipUnit") {
                implementation(project(":" + skipModuleName))
            }
        }
    }
}

kotlin {
    jvmToolchain(17)
}

tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>() {
    kotlinOptions {
        suppressWarnings = true
    }
}

tasks.withType<Test>().configureEach {
    systemProperties.put("robolectric.logging", "stdout")
    systemProperties.put("robolectric.graphicsMode", "NATIVE")
    testLogging {
        this.showStandardStreams = true
    }
}

fun prop(key: String): String {
    val value = System.getProperty("SKIP_" + key, System.getenv(key))
    if (value == null) {
        throw GradleException("Required key ${key} is not set")
    }
    return value
}

// add the "launchDebug" and "launchRelease" commands
listOf("Debug", "Release").forEach { buildType ->
    task("launch" + buildType) {
        dependsOn("install" + buildType)

        doLast {
            val activity = prop("PRODUCT_BUNDLE_IDENTIFIER") + "/" + prop("ANDROID_PACKAGE_NAME") + ".MainActivity"

            var adbCommand = "adb"
            if (org.gradle.internal.os.OperatingSystem.current().isWindows) {
                adbCommand += ".exe"
            }

            exec {
                commandLine = listOf(
                    adbCommand,
                    "shell",
                    "am",
                    "start",
                    "-a",
                    "android.intent.action.MAIN",
                    "-c",
                    "android.intent.category.LAUNCHER",
                    "-n",
                    "$activity"
                )
            }
        }
    }
}
