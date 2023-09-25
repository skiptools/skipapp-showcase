# SkipUI

SwiftUI support for [Skip](https://skip.tools) apps.

## About 

SkipUI vends the `skip.ui` Kotlin package. It is a reimplementation of SwiftUI for Kotlin on Android using Jetpack Compose. Its goal is to mirror as much of SwiftUI as possible, allowing Skip developers to use SwiftUI with confidence.

## Dependencies

SkipUI depends on the [skip](https://source.skip.tools/skip) transpiler plugin. The transpiler must transpile SkipUI's own source code, and SkipUI relies on the Transpiler's transformation of SwiftUI code. See [Implementation Strategy](#implementation-strategy) for details.

SkipUI is part of the core Skip stack and is not intended to be imported directly.
The module is transparently adopted through the translation of `import SwiftUI` into `import skip.ui.*` by the Skip transpiler.

## Status

SkipUI is a young library, and there is much left to do. The following table lists supported SwiftUI constructs and components. Anything not listed here is likely not yet supported.

|Component|Support Level|Notes|
|---------|-------------|-----|
|`@Bindable`|Full||
|`@Binding`|Full||
|`@Environment`|Full||
|Environment builtins|Low||
|`@EnvironmentObject`|Full||
|`@ObservedObject`|Full||
|`@State`|Full||
|`@StateObject`|Full||
|Custom Views|Full||
|`Button`|High||
|`Color`|High||
|`Divider`|Full||
|`EmptyView`|Full||
|`Font`|Medium||
|`Group`|Full||
|`HStack`|Full||
|`Image`|Low|See [Images](#images)|
|`List`|Medium|See [Lists](#lists)|
|`NavigationLink`|Medium|See [Navigation](#navigation)|
|`NavigationStack`|Medium|See [Navigation](#navigation)|
|`ScrollView`|Full||
|`Slider`|Medium|Labels, `onEditingChanged` not supported|
|`Spacer`|Medium|`minLength` not supported|
|`Text`|High|Formatting not supported|
|`TextField`|High|Formatting not supported|
|`Toggle`|Medium|Styling, `sources` not supported|
|`VStack`|Full||
|`ZStack`|Full||
|`.background`|Low|Only color supported|
|`.bold`|Full||
|`.border`|Full||
|`.buttonStyle`|High|Custom styles not supported|
|`.environment`|Full||
|`.environmentObject`|Full||
|`.font`|Full||
|`.foregroundColor`|Full||
|`.foregroundStyle`|Medium|Only color supported|
|`.frame`|Low|Only fixed dimensions supported|
|`.italic`|Full||
|`.labelsHidden`|Full||
|`.listStyle`|Full||
|`.navigationDestination`|Medium|See [Navigation](#navigation)|
|`.navigationTitle`|Full||
|`.opacity`|Full||
|`.padding`|Full||
|`.rotationEffect`|Medium||
|`.scaleEffect`|Medium||
|`.task`|Full||

## Contributing

We welcome contributions to SkipUI. The Skip product documentation includes helpful instructions on [local Skip library development](https://skip.tools/docs/#local-libraries). 

The most pressing need is to implement more core components and view modifiers.
To help fill in unimplemented API in SkipUI:

1. Find unimplemented API. Unimplemented API will either be within `#if !SKIP` blocks, or will be marked with `@available(unavailable, *)`.
1. If the code is in a `#if !SKIP` block, the first step is to move it out so that it will be transpiled. This is helpful on its own, even if you just mark the API `@available(unavailable, *)` because you are not ready to implement it for Compose. That will provide Skip users with a clear error message, rather than relying on the Kotlin compiler to complain about unfound API.
    - When moving code out of a `#if !SKIP` block, please strip Apple's extensive API comments. There is no reason for Skip to duplicate the official SwiftUI documentation, and it obscures any Skip-specific implementation comments we may add.
    - SwiftUI uses complex generics extensively, and the generics systems of Swift and Kotlin have significant differences. You may have to replace some generics or generic constraints with looser typing in order to transpile successfully.
1. Write an appropriate Compose implementation. See [Implementation Strategy](#implementation-strategy) below.
1. Write unit tests if appropriate. When implementing a UI component or modifier, add a playground - or enhance an existing playground - to exercise your implementation in the [Skip playground app](https://github.com/skiptools/skipapp-playground).
1. [Submit a PR.](pulls)

Other forms of contributions such as test cases, comments, and documentation are also welcome!

## Implementation Strategy

Documentation in progress

## Topics

### Images

Documentation in progress

### Lists

Documentation in progress

### Navigation

Documentation in progress

## Tests

Documentation in progress
