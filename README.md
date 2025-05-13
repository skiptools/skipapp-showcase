# Skip Component Showcase

Showcase is a [Skip Lite](https://skip.tools) app that demonstrates many of the components available in SkipUI.

[<img src="https://upload.wikimedia.org/wikipedia/commons/7/78/Google_Play_Store_badge_EN.svg" alt="Get it on Google Play Store" height="80">](https://play.google.com/store/apps/details?id=org.appfair.app.Showcase) [<img src="https://developer.apple.com/assets/elements/badges/download-on-the-app-store.svg" alt="Get it on App Store" height="80">](https://apps.apple.com/us/app/skip-showcase/id6474885022)


## Quickstart

This repository contains an Xcode project with a SwiftUI app that uses the
Skip plugin to transpile the app into Kotlin then build and launch it on Android.
To get started:

1. Install skip (requires macOS 13+ with [Homebrew](https://brew.sh), [Xcode](https://developer.apple.com/xcode/), and [Android Studio](https://developer.android.com/studio)) with the Terminal command:
```
$ brew install skiptools/skip/skip
```
2. Configure and launch an Android emulator from the [Android Studio device manager](https://developer.android.com/studio/run/emulator-launch-without-app).
3. Download this [repository as a zip file](https://github.com/skiptools/skipapp-showcase/archive/main.zip) and unzip it, or clone the repository:
```
$ git clone https://github.com/skiptools/skipapp-showcase.git
```
4. Navigate to the *Darwin* folder and open the Xcode project: `Showcase.xcodeproj`
5. Select and Run the `Showcase` target with an iOS simulator destination; the app will build and run side-by-side on the iOS simulator and Android emulator.


## Project

This project was initialized with the command:

```
skip init --no-module-tests --no-build --icon-color=8E8E93 --free --zero --appid=skip.showcase.App skipapp-showcase Showcase
```


## Testing

The module can be tested using the standard `swift test` command
or by running the test target for the macOS destination in Xcode,
which will run the Swift tests as well as the transpiled
Kotlin JUnit tests in the Robolectric Android simulation environment.

Parity testing can be performed with `skip test`,
which will output a table of the test results for both platforms.

## Contributing

We welcome contributions to this package in the form of enhancements and bug fixes.

The general flow for contributing to this and any other Skip package is:

1. Fork this repository and enable actions from the "Actions" tab
2. Check out your fork locally
3. When developing alongside a Skip app, add the package to a [shared workspace](https://skip.tools/docs/contributing) to see your changes incorporated in the app
4. Push your changes to your fork and ensure the CI checks all pass in the Actions tab
5. Add your name to the Skip [Contributor Agreement](https://github.com/skiptools/clabot-config)
6. Open a Pull Request from your fork with a description of your changes

## Running

Xcode and Android Studio must be downloaded and installed in order to
run the app in the iOS simulator / Android emulator.
An Android emulator must already be running, which can be launched from 
Android Studio's Device Manager.

To run both the Swift and Kotlin apps simultaneously, 
launch the FireSideApp target from Xcode.
A build phases runs the "Launch Android APK" script that
will deploy the transpiled app a running Android emulator or connected device.
Logging output for the iOS app can be viewed in the Xcode console, and in
Android Studio's logcat tab for the transpiled Kotlin app.
