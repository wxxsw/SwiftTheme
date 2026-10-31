# Theme configuration and compatibility notes

## Navigation bars and tab bars

On iOS 13–18, use appearance objects for themed navigation/tab bar backgrounds. On iOS 15+, configure the scroll-edge appearance as well, otherwise the bar can become transparent at a scroll edge. Bind pickers to the actual bars owned by your controllers so existing visible UI updates with the theme.

```swift
// Run on the main thread, after creating the navigation/tab controllers.
if #available(iOS 13.0, *) {
    let navigationPicker = ThemeNavigationBarAppearancePicker(keyPath: "Global.barTintColor") { value in
        guard let hex = value as? String else { return nil }
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(rgba: hex)
        return appearance
    }
    navigationController.navigationBar.theme_standardAppearance = navigationPicker
    navigationController.navigationBar.theme_compactAppearance = navigationPicker
    navigationController.navigationBar.theme_scrollEdgeAppearance = navigationPicker
    if #available(iOS 15.0, *) {
        navigationController.navigationBar.theme_compactScrollEdgeAppearance = navigationPicker
    }

    let tabPicker = ThemeTabBarAppearancePicker(keyPath: "Global.barTintColor") { value in
        guard let hex = value as? String else { return nil }
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(rgba: hex)
        return appearance
    }
    tabBarController.tabBar.theme_standardAppearance = tabPicker
    if #available(iOS 15.0, *) {
        tabBarController.tabBar.theme_scrollEdgeAppearance = tabPicker
    }
}
```

This example intentionally sets opaque backgrounds for the older design. For iOS 26 Liquid Glass, prefer the system background/material instead. The demos use `configureWithDefaultBackground()` and adaptive foreground colors on iOS 26, so their bars no longer reproduce the solid theme background used on earlier systems. Theme colors still apply to the content. See [Apple's Liquid Glass adoption guidance](https://developer.apple.com/documentation/technologyoverviews/adopting-liquid-glass).

Configure navigation title attributes on the `UINavigationBarAppearance`. Configure tab item attributes on its stacked, inline and compact-inline item appearances as appropriate. The system tab separator is controlled by the appearance's `shadowColor` / `shadowImage`; it is different from a custom view's layer border.

`UITabBar` has no `compactAppearance` property. The old `theme_compactAppearance` tab bar binding is deprecated because its target setter does not exist. Use the standard/scroll-edge bindings instead.

## UIAppearance and tab item title attributes

Do not assume that every custom `theme_*` method works through a UIKit appearance proxy. In particular, `UITabBarItem.appearance().theme_setTitleTextAttributes(...)` can crash while UIKit applies appearance invocations to its internal tab label (issue #147).

Bind to the real item instead:

```swift
let titlePicker = ThemeStringAttributesPicker.pickerWithAttributes([
    [.foregroundColor: UIColor.black],
    [.foregroundColor: UIColor.white]
])
viewController.tabBarItem.theme_setTitleTextAttributes(titlePicker, forState: .normal)
```

Bind each item's picker when creating that item, on the main thread. For modern tab bars, configuring item states through `UITabBarAppearance` is another option. Binding to an appearance proxy is not a substitute for observing and updating already-visible instances.

## Hex colors and alpha

The accepted formats are `#RGB`, `#RGBA`, `#RRGGBB` and `#RRGGBBAA`. Alpha is last, not first:

```swift
UIColor(hex8: 0xFF000080)        // red, alpha = 128 / 255
UIColor(rgba: "#FF000080")      // same color
UIColor(rgba: "#1234")          // expands to #11223344
```

Convert ARGB inputs to RGBA before passing them to these APIs. Changing the existing parser to ARGB would change the meaning of existing themes.

## Attributed strings from Plist or JSON

Store the text and styling data in the theme, then construct `NSAttributedString` with the map initializer. For example, this JSON has the same dictionary/array structure you can create in a Plist:

```json
{
  "Label": {
    "text": "Hello",
    "color": "#FF0000"
  },
  "Gradient": {
    "colors": ["#FF0000", "#FFFFFF"]
  }
}
```

```swift
label.theme_attributedText = ThemeAttributedStringPicker(keyPath: "Label") { value in
    guard let settings = value as? [String: String],
          let text = settings["text"],
          let hex = settings["color"] else { return nil }
    return NSAttributedString(string: text, attributes: [
        .foregroundColor: UIColor(rgba: hex)
    ])
}
```

For multiple ranges, build an `NSMutableAttributedString` inside the map closure and apply attributes to each range. Validate ranges against the string's UTF-16 length before applying them. The theme file holds data, not a serialized `NSAttributedString` object.

For predefined attributed strings in index mode, these forms select one string per theme:

```swift
let first = NSAttributedString(string: "Light")
let second = NSAttributedString(string: "Dark")
label.theme_attributedText = ThemeAttributedStringPicker([first, second])
// Or use the array-literal conformance:
label.theme_attributedText = [first, second]
```

## Gradient colors from Plist or JSON

Using the `Gradient.colors` array above:

```swift
gradientLayer.theme_colors = ThemeAnyPicker(keyPath: "Gradient.colors") { value in
    guard let hexes = value as? [String] else { return nil }
    return hexes.map { UIColor(rgba: $0).cgColor }
}
```

`CAGradientLayer.colors` expects `CGColor` values. Update the gradient layer's frame in your layout code as usual.

## Transparent containers and shadows

When a container is transparent and `shadowPath` is nil, Core Animation can derive the shadow from its sublayers, including labels. For a shadow around the container's bounds, set an explicit `shadowPath` in `layoutSubviews()` or the owning controller's `viewDidLayoutSubviews()`. Keep the path in sync with bounds and corner-radius changes. See [Apple's shadowPath documentation](https://developer.apple.com/documentation/quartzcore/calayer/shadowpath).

For a custom layer border, use `theme_borderColor` and `theme_borderWidth`; table reloads and per-cell theme observers are unnecessary just to update those properties.

## Current boundaries

- **Main thread:** UIKit bindings and `ThemeManager.setTheme` calls that update UIKit must run on the main thread. The library does not automatically dispatch them there.
- **Independent page themes:** `ThemeManager` is global/static. Constructing multiple instances does not isolate their state. For native light/dark appearance on one page, use `overrideUserInterfaceStyle` and adaptive colors/assets on that page; existing SwiftTheme bindings still follow the global theme. For modern custom scoped themes, consider [UIKit custom traits](https://developer.apple.com/documentation/uikit/providing-data-to-the-view-hierarchy-with-custom-traits).
- **SwiftUI:** There is no built-in SwiftUI binding layer. Use observable state and a custom Environment value for native views, or wrap themed UIKit components. An app-level adapter can observe `ThemeUpdateNotification` on the main thread, but SwiftUI still needs observable state to invalidate its views.
- **Circular reveal transitions:** The library's animation duration controls normal UIKit updates, not a circular reveal. A snapshot/mask transition needs to be implemented by the application, including Reduce Motion handling and interruption cleanup.
