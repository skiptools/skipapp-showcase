# Android Skip app

This folder contains the scaffolding for the Android half of the Skip app.

## Structure

The Android folder will look something like this:

```plaintext
Android/
├── README.md
├── app
│   ├── build.gradle.kts
│   ├── keystore.jks -> ../../../keystore.jks
│   ├── keystore.properties -> ../../../keystore.properties
│   ├── proguard-rules.pro
│   └── src
│       └── main
│           ├── AndroidManifest.xml
│           ├── kotlin
│           │   └── showcase
│           │       └── module
│           │           └── Main.kt
│           └── res
│               └── mipmap-xxxhdpi
│                   └── ic_launcher.png
├── fastlane
│   ├── Appfile
│   ├── Fastfile
├── gradle
│   └── wrapper
│       └── gradle-wrapper.properties
├── gradle.properties
└── settings.gradle.kts
```

## Signing

Create the `Android/app/keystore.jks` file by running this command and following the prompts:

```shell
keytool -genkeypair -v -keystore Android/app/keystore.jks -keyalg RSA -keysize 2048 -validity 100000 -alias app
```

Then create a new `Android/app/keystore.properties` file with the contents:

```env
keyAlias=app
storeFile=keystore.jks
storePassword=PASSWORD
keyPassword=PASSWORD
```

Once the keystore has been configured, create a release build with:

```shell
skip gradle -p Android/ bundleRelease
```

You can verify that the bundle is signed with the command:

```shell
keytool -printcert -jarfile .build/Android/app/outputs/bundle/release/app-release.aab
```

If the bundle is successfully signed, it can be uploaded to the Play console.




