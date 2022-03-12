# NavigationItem for SwiftUI

## Usage

The `.navigationItem` modifier has to be applied to the `NavigationItem` because otherwise the Environment will not be applied to the `NavigationLink` destinations. On child views you can apply them anywhere just like `.navigationTitle`

```swift
NavigationView {
    // content
}
.navigationItem { navigationItem in
    // Customize the NavigationItem here
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
