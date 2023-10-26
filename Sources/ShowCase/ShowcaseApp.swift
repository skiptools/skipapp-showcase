import Foundation
import OSLog
import SwiftUI

/// The Android SDK number we are running against, or `nil` if not running on Android
let androidSDK = ProcessInfo.processInfo.environment["android.os.Build.VERSION.SDK_INT"].flatMap({ Int($0) })

/// The shared top-level view for the app, loaded from the platform-specific App delegates below.
///
/// The default implementation merely loads the `ContentView` for the app and logs a message.
struct RootView : View {
    var body: some View {
        ContentView()
            .task {
                logger.log("Welcome to Skip on \(androidSDK != nil ? "Android" : "Darwin")!")
                logger.warning("Skip app logs are viewable in the Xcode console for iOS; Android logs can be viewed in Studio or using adb logcat")
            }
    }
}

#if !SKIP
public protocol ShowcaseApp : App {
}

/// The entry point to the Showcase app.
/// The concrete implementation is in the ShowcaseApp module.
public extension ShowcaseApp {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

#else
import android.Manifest
import android.app.Application
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.Box
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.saveable.rememberSaveableStateHolder
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.core.app.ActivityCompat

/// AndroidAppMain is the `android.app.Application` entry point, and must match `application android:name` in the AndroidMainfest.xml file.
public class AndroidAppMain : Application {
    public init() {
    }

    public override func onCreate() {
        super.onCreate()
        logger.info("starting app")
        ProcessInfo.launch(applicationContext)
    }
}

/// AndroidAppMain is initial `androidx.appcompat.app.AppCompatActivity`, and must match `activity android:name` in the AndroidMainfest.xml file.
public class MainActivity : AppCompatActivity {
    public init() {
    }

    public override func onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            let saveableStateHolder = rememberSaveableStateHolder()
            saveableStateHolder.SaveableStateProvider(true) {
                Box(modifier: Modifier.fillMaxSize(), contentAlignment: Alignment.Center) {
                    MaterialThemedRootView()
                }
            }
        }

        // Example of requesting permissions on startup. 
        // These must match the permissions in the AndroidManifest.xml file.
        //let permissions = listOf(
        //    Manifest.permission.ACCESS_COARSE_LOCATION,
        //    Manifest.permission.ACCESS_FINE_LOCATION
        //    Manifest.permission.CAMERA,
        //    Manifest.permission.WRITE_EXTERNAL_STORAGE,
        //)
        //let requestTag = 1
        //ActivityCompat.requestPermissions(self, permissions.toTypedArray(), requestTag)
    }

    public override func onSaveInstanceState(bundle: android.os.Bundle) {
        super.onSaveInstanceState(bundle)
    }

    public override func onRestoreInstanceState(bundle: android.os.Bundle) {
        // Usually you restore your state in onCreate(). It is possible to restore it in onRestoreInstanceState() as well, but not very common. (onRestoreInstanceState() is called after onStart(), whereas onCreate() is called before onStart().
        logger.info("onRestoreInstanceState")
        super.onRestoreInstanceState(bundle)
    }

    public override func onRestart() {
        logger.info("onRestart")
        super.onRestart()
    }

    public override func onStart() {
        logger.info("onStart")
        super.onStart()
    }

    public override func onResume() {
        logger.info("onResume")
        super.onResume()
    }

    public override func onPause() {
        logger.info("onPause")
        super.onPause()
    }

    public override func onStop() {
        logger.info("onStop")
        super.onStop()
    }

    public override func onDestroy() {
        logger.info("onDestroy")
        super.onDestroy()
    }

    public override func onRequestPermissionsResult(requestCode: Int, permissions: kotlin.Array<String>, grantResults: IntArray) {
        logger.info("onRequestPermissionsResult: \(requestCode)")
    }
}

 @Composable func MaterialThemedRootView() {
    let context = LocalContext.current
    let darkMode = isSystemInDarkTheme()
    // Dynamic color is available on Android 12+
    let dynamicColor = android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S

    let colorScheme = dynamicColor
        ? (darkMode ? dynamicDarkColorScheme(context) : dynamicLightColorScheme(context))
        : (darkMode ? darkColorScheme() : lightColorScheme())

    MaterialTheme(colorScheme: colorScheme) {
        RootView().Compose()
    }
}

#endif
