# NavigationItem for SwiftUI

## Why

SwiftUI doesn't expose the `UINavigationItem` from the `NavigationView` but sometimes you might want to access it to set the `prompt` or the `backButtonDisplayMode`.
With this modifier you can easily customize the `UINavigationItem` of your SwiftUI `NavigationView`s.

## Usage

The `.navigationItem` modifier has to be applied to the `NavigationItem` (or `NavigationStack`, `NavigationSplitView` when using iOS 16+) because otherwise the Environment will not be applied to the `NavigationLink` destinations. On child views you can apply them anywhere just like `.navigationTitle`

```swift
NavigationView {
    // content
}
.navigationItem { navigationItem in
    // Customize the NavigationItem here
    navigationItem.prompt = "Enter information"
    navigationItem.backButtonDisplayMode = .generic
}
```

## Install

### SwiftPM

```
https://github.com/divadretlaw/SwiftUI-NavigationItem.git
```

## License

See [LICENSE](LICENSE)

Copyright © 2022 David Walter (www.davidwalter.at)
