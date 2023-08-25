// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org
#if SKIP
import AppModel
import Foundation
import SwiftUI

import AndroidApp
import AndroidContent.Context
import AndroidxAppcompatApp
import AndroidxActivityCompose
import AndroidxComposeRuntime
import AndroidxComposeMaterial3
import AndroidxComposeFoundation
import AndroidxComposeUi
import AndroidxComposeUiPlatform


@ExperimentalMaterial3Api
@Composable func RootView() {
    let context: Context = LocalContext.current
    let darkMode = isSystemInDarkTheme()
    let dynamicColor = android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.S
    let typography = Typography()
    let colorScheme = dynamicColor
        ? (darkMode ? dynamicDarkColorScheme(context) : dynamicLightColorScheme(context))
        : (darkMode ? darkColorScheme() : lightColorScheme())

    MaterialTheme(colorScheme: colorScheme, typography: typography) {
        ContentView().Compose(ComposeContext())
    }
}


/// AndroidAppMain is initial `androidx.appcompat.app.AppCompatActivity`, and must match `activity android:name` in the AndroidMainfest.xml file
public class MainActivity : AppCompatActivity {
    public init() {
    }

    @ExperimentalMaterial3Api
    public override func onCreate(savedInstanceState: android.os.Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            RootView()
        }
    }

    public override func onSaveInstanceState(bundle: android.os.Bundle) {
        super.onSaveInstanceState(bundle)
    }

    public override func onRestoreInstanceState(bundle: android.os.Bundle) {
        super.onRestoreInstanceState(bundle)
    }

    public override func onRestart() {
        logger.log("onRestart")
        super.onRestart()
    }

    public override func onStart() {
        logger.log("onStart")
        super.onStart()
    }

    public override func onResume() {
        logger.log("onResume")
        super.onResume()
    }

    public override func onPause() {
        logger.log("onPause")
        super.onPause()
    }

    public override func onStop() {
        logger.log("onStop")
        super.onStop()
    }

    public override func onDestroy() {
        logger.log("onDestroy")
        super.onDestroy()
    }
}

/// AndroidAppMain is the `android.app.Application` entry point, and must match `application android:name` in the AndroidMainfest.xml file
public class AndroidAppMain : Application {
    public init() {
    }

    public override func onCreate() {
        super.onCreate()
        ProcessInfo.launch(applicationContext)
    }
}
#endif
