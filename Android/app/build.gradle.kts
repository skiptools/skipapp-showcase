import java.io.FileInputStream
import java.util.Properties

plugins {
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.android.application)
}

val keystorePropertiesFile = file("keystore.properties")

android {
    compileSdk = libs.versions.android.sdk.compile.get().toInt()
    defaultConfig {
        minSdk = libs.versions.android.sdk.min.get().toInt()

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
    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                val keystoreProperties = Properties()
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))

                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
                storeFile = file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.findByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            isDebuggable = false
            proguardFiles(getDefaultProguardFile("proguard-android.txt"), "proguard-rules.pro")
        }
    }
    namespace = group as String

    compileOptions {
        sourceCompatibility = JavaVersion.toVersion(libs.versions.jvm.get())
        targetCompatibility = JavaVersion.toVersion(libs.versions.jvm.get())
    }

    composeOptions {
        kotlinCompilerExtensionVersion = libs.versions.kotlin.compose.compiler.extension.get()
    }
}

fun prop(key: String): String {
    val value = System.getProperty("SKIP_" + key, System.getenv(key))
    if (value == null) {
        throw GradleException("Required key ${key} is not set")
    }
    return value
}

//@include:file("")

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

dependencies {
    implementation("showcase.module:Showcase")
}

kotlin {
    jvmToolchain(libs.versions.jvm.get().toInt())
}

tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>() {
    kotlinOptions {
        suppressWarnings = true
    }
}
