![SwiftTheme](https://raw.githubusercontent.com/wxxsw/SwiftThemeResources/master/Screenshots/logo.png)

<p align="center">
<a href="#introduction">Introduction</a> -
<a href="#demos">Demos</a> -
<a href="#installation">Installation</a> -
<a href="#documents">Documents</a> -
<a href="#faq">FAQ</a> -
<a href="#contribution">Contribution</a> -
<a href="README_CN.md">中文文档</a>
</p>

<p align="center">
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-swift5-f48041.svg?style=flat"></a>
<a href="http://cocoadocs.org/docsets/SwiftTheme"><img src="https://img.shields.io/cocoapods/v/SwiftTheme.svg?style=flat"></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="https://developer.apple.com/ios"><img src="https://img.shields.io/badge/platform-iOS%209%2B | tvOS%209%2B-blue.svg?style=flat"></a>
<a href="https://github.com/wxxsw/SwiftTheme/blob/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat"></a>
</p>

Practical configuration examples and compatibility limits: [Theme configuration notes](docs/UsageNotes.md).

## Screenshot

![](https://github.com/wxxsw/SwiftThemeResources/blob/master/Screenshots/switch.gif)

> Running：open `SwiftTheme.xcworkspace`, run target `PlistDemo`

## Introduction
### The Beginning Of The Story

As part of our project requirement, we need to add night mode to our app. It's not as simple as just changing brightness or alpha on the top-level view—in fact, it needs an entirely new interface: different colors, different alpha, different image cuts. More accurately, "night mode" is a theme/skinning feature that can switch between bright theme and dark themes.

So how do we achieve this? Maybe we can set a global variable that represents the currently selected theme, and use different background colors or image cuts based on the variable during the controller's initialization. But then how do we deal with views that have already been initialized? Yes, we could use notifications to change their colors or image cuts, but this leads to controllers unnecessarily full of notification register/unregister, if...else and UI updating code. Worse, if you forget to unregister the notifications, your app may crash.

After some consideration, we put forward higher requirements on the task: create a simple and reusable themes/skinning framework, here as you see.

### Goals

Make SwiftTheme a simple, powerful, high-performance, extensible themes/skinning framework. Provide a unified solution for iOS.

## Demos


### Index Mode

Vary background color of UIView according to the theme setting:

```swift
view.theme_backgroundColor = ["#FFF", "#000"]
```

Vary text color of UILabel and UIButton:

```swift
label.theme_textColor = ["#000", "#FFF"]
button.theme_setTitleColor(["#000", "#FFF"], forState: .Normal)
```

Vary image of UIImageView:

```swift
imageView.theme_image = ["day", "night"]

// It's ok by using UIImage instances if you don't want to use image names.
imageView.theme_image = ThemeImagePicker(images: image1, image2)
```

A miracle happens after you execute the single line of code below!

```swift
// these numbers represent the parameters' index. 
// eg. "view.theme_backgroundColor = ["#FFF", "#000"]", index 0 represents "#FFF", index 1 represents "#000"
ThemeManager.setTheme(index: isNight ? 1 : 0)
```

Get current theme index.

```swift
ThemeManager.currentThemeIndex	// Readonly
```

> Index mode is a fast way for the situation: a few themes, but not many, no need to download more new themes.

Notice About Literal:

```swift
// Wrong example:
let colors = ["#FFF", "#000"]
view.theme_backgroundColor = colors

// You should write like this:
view.theme_backgroundColor = ["#FFF", "#000"]
// or this:
let colorPickers: ThemeColorPicker = ["#FFF", "#000"]
view.theme_backgroundColor = colorPickers
```

> Because theme_backgroundColor accepts an argument of type ThemeColorPicker，not Array. Nevertheless, "view.theme_backgroundColor = ["#FFF", "#000"]" does the same as initializing an instance of ThemeColorPicker by "Literal" and passing it to the theme_backgroundColor.



### Plist/JSON Mode
You may want to make your app download and install an indefinite number of themes. To fulfill this requirement, we provide plist mode. Simply put, you write configuration info such as colors, image cuts and so on, in a plist file. Then, you can use their keys in the logic code. So, the plist file and the resource files are used to constitute a theme package.

Usage demo of plist mode.

```swift
view.theme_backgroundColor = "Global.backgroundColor"
imageView.theme_image = "SelectedThemeCell.iconImage"
```
> Similar with the index mode. Only the specific parameters become keys. And as such, we give it the extension ability.


The plist file name is the first paramter of the switching method. In this example, the plist file and other resource files are in the application bundle. It's also ok if they are in sandbox.

```swift
ThemeManager.setTheme(plistName: "Red", path: .mainBundle)
```

> plist mode allow you install more themes without modifying logic code. So, you can add the feature that, downloading and installing themes for your app.

the screenshots of the plist and image files we used above:

![](https://github.com/wxxsw/SwiftThemeResources/blob/master/Screenshots/1.pic.jpg)
![](https://github.com/wxxsw/SwiftThemeResources/blob/master/Screenshots/2.pic.jpg)

### Objective-C

Fully compatible with Objective-C, usage demo:

```objective-c
lbl.theme_backgroundColor = [ThemeColorPicker pickerWithColors:@[@"#FAF9F9", @"#E2E2E2"]];
```

### Features
- [x] Written in Swift
- [x] Fully compatible with Objective-C
- [x] Based on runtime
- [x] Simple integration
- [x] Extension property prefix with "theme_*", friendly with IDE auto-completion
- [x] Support UIAppearance
- [x] Index mode, fast integration
- [x] Plist mode, extend infinite themes
- [x] Friendly error logs
- [x] Strongly typed ThemePicker, detect errors during compilling
- [x] Complete demos


## Installation

#### CocoaPods
```swift
pod 'SwiftTheme'
use_frameworks!
```

#### Carthage
```swift
github "wxxsw/SwiftTheme"
```

#### Swift Package Manager

1. Select `Xcode -> File -> Swift Packages -> Add Package Dependency...` 
2. Enter `https://github.com/wxxsw/SwiftTheme`.
3. Click `Next`, then select the version, complete.

#### Source files
Copy all the files in "Sources" folder into your project

## Documents

Note：`①` usage of index mode `②` usage of plist mode

### *Basic Usage*
***

#### Configure Appearance

SwiftTheme provides new properties for views, they all beigin with `theme_`. Such as `theme_backgroundColor` corresponds `backgroundColor`.

```swift
①
view.theme_backgroundColor = ThemeColorPicker(colors: "#FFF", "#000")
view.theme_image = ThemeImagePicker(names: "day", "night")
②
view.theme_backgroundColor = ThemeColorPicker(keyPath: "SomeColorKeyPath")
view.theme_image = ThemeImagePicker(keyPath: "SomeImageKeyPath")
```
> Different type of properties receive different type of Pickers. Thus, IDE will warn you if you pass a wrong parameter.

#### Switch Themes

When you switch themes, all the `theme_` properties you set will update with animation. Usage:

```swift
①
ThemeManager.setTheme(index: 0) // ThemePickers will use the first parameter, eg. "#FFF" "day"
ThemeManager.setTheme(index: 1) // ThemePickers will use the second parameter, eg. "#000" "night"
②
// use "day.plist" in the appllication bundle as the theme configuration file. 
// In this mode, SwiftTheme will find the resource files in the appllication bundle.
ThemeManager.setTheme(plistName: "day", path: .mainBundle)
// use "night.plist" in the sandbox as the theme configuration file, "someURL" is its file path. 
// In this mode, SwiftTheme will find the resource files in the same path.
ThemeManager.setTheme(plistName: "night", path: .sandbox(someURL))
// use a dictionary as the theme configuration, but find resource files in the sandbox.(Not recommend)
ThemeManager.setTheme(dict: dict, path: .sandbox(someURL))
```

#### Custom Behaviors

SwiftTheme posts a notification named `ThemeUpdateNotification` when theme changes, you can observe this notification anywhere and do whatever you want:
```swift
NotificationCenter.default.addObserver(
	self, 
	selector: #selector(doSomethingMethod),
	name: NSNotification.Name(rawValue: ThemeUpdateNotification), 
	object: nil
)
```
```objective-c
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomethingMethod) name:@"ThemeUpdateNotification" object:nil];
```

### *Now Supported Properties*
***

> Child classes inherit the properties from their super class, such as UILabel have theme_alpha inherited from UIView. These properties will not be list in child classes below.

##### UIView
- var theme_alpha: ThemeCGFloatPicker?
- var theme_backgroundColor: ThemeColorPicker?
- var theme_tintColor: ThemeColorPicker?

##### UIApplication
- func theme_setStatusBarStyle(picker: ThemeStatusBarStylePicker, animated: Bool)

##### UIBarButtonItem
- var theme_tintColor: ThemeColorPicker?

##### UILabel
- var theme_font: ThemeFontPicker?
- var theme_textColor: ThemeColorPicker?
- var theme_textAttributes: ThemeStringAttributesPicker?
- var theme_highlightedTextColor: ThemeColorPicker?
- var theme_shadowColor: ThemeColorPicker?

##### UINavigationBar
- var theme_barStyle: ThemeBarStylePicker?
- var theme_barTintColor: ThemeColorPicker?
- var theme_titleTextAttributes: ThemeDictionaryPicker?

##### UITabBar
- var theme_barStyle: ThemeBarStylePicker?
- var theme_barTintColor: ThemeColorPicker?

##### UITableView
- var theme_separatorColor: ThemeColorPicker?

##### UITextField
- var theme_font: ThemeFontPicker?
- var theme_keyboardAppearance: ThemeKeyboardAppearancePicker?
- var theme_textColor: ThemeColorPicker?
- var theme_placeholderAttributes: ThemeDictionaryPicker?

##### UITextView
- var theme_font: ThemeFontPicker?
- var theme_textColor: ThemeColorPicker?

##### UIToolbar
- var theme_barStyle: ThemeBarStylePicker?
- var theme_barTintColor: ThemeColorPicker?

##### UISegmentedControl
- var theme_selectedSegmentTintColor: ThemeColorPicker?
- func theme_setTitleTextAttributes(_ picker: ThemeStringAttributesPicker?, forState state: UIControl.State)

##### UISwitch
- var theme_onTintColor: ThemeColorPicker?
- var theme_thumbTintColor: ThemeColorPicker?

##### UISlider
- var theme_thumbTintColor: ThemeColorPicker?
- var theme_minimumTrackTintColor: ThemeColorPicker?
- var theme_maximumTrackTintColor: ThemeColorPicker?

##### UISearchBar
- var theme_barStyle: ThemeBarStylePicker?
- var theme_barTintColor: ThemeColorPicker?

##### UIProgressView
- var theme_progressTintColor: ThemeColorPicker?
- var theme_trackTintColor: ThemeColorPicker?

##### UIPageControl
- var theme_pageIndicatorTintColor: ThemeColorPicker?
- var theme_currentPageIndicatorTintColor: ThemeColorPicker?

##### UIImageView
- var theme_image: ThemeImagePicker?

##### UIActivityIndicatorView
- var theme_activityIndicatorViewStyle: ThemeActivityIndicatorViewStylePicker?

##### UIButton
- func theme_setImage(picker: ThemeImagePicker?, forState state: UIControlState)
- func theme_setBackgroundImage(picker: ThemeImagePicker?, forState state: UIControlState)
- func theme_setTitleColor(picker: ThemeColorPicker?, forState state: UIControlState)
- func theme_setAttributedTitle(picker: ThemeAttributedStringPicker?, forState state: UIControlState)

##### CALayer
- var theme_backgroundColor: ThemeCGColorPicker?
- var theme_borderWidth: ThemeCGFloatPicker?
- var theme_borderColor: ThemeCGColorPicker?
- var theme_shadowColor: ThemeCGColorPicker?

##### CATextLayer
- var theme_foregroundColor: ThemeCGColorPicker?

##### CAGradientLayer
- var theme_colors: ThemeAnyPicker?

##### UIRefreshControl
- var theme_titleAttributes: ThemeDictionaryPicker?

##### UIVisualEffectView
- var theme_effect: ThemeVisualEffectPicker?

### *Picker*
***

#### ThemeColorPicker
```swift
// supported formats:
// "#ffcc00"		RGB
// "#ffcc00dd"		RGBA
// "#FFF"			RGB in short
// "#013E"			RGBA in short
①
ThemeColorPicker(colors: "#FFFFFF", "#000")
ThemeColorPicker(colors: UIColor.red, UIColor.blue)
ThemeColorPicker.pickerWithColors(["#FFFFFF", "#000"])
ThemeColorPicker.pickerWithUIColors([UIColor.red, UIColor.blue])
②
ThemeColorPicker(keyPath: "someStringKeyPath")
ThemeColorPicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeImagePicker
```swift
①
ThemeImagePicker(names: "image1", "image2")
ThemeImagePicker.pickerWithNames(["image1", "image2"])
ThemeImagePicker(images: UIImage(named: "image1")!, UIImage(named: "image2")!)
ThemeImagePicker.pickerWithImages([UIImage(named: "image1")!, UIImage(named: "image2")!])
②
ThemeImagePicker(keyPath: "someStringKeyPath")
ThemeImagePicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeCGFloatPicker
```swift
①
ThemeCGFloatPicker(floats: 1.0, 0.7)
ThemeCGFloatPicker.pickerWithFloats([1.0, 0.7])
②
ThemeCGFloatPicker(keyPath: "someNumberKeyPath")
ThemeCGFloatPicker.pickerWithKeyPath("someNumberKeyPath")
```

#### ThemeCGColorPicker
```swift
①
ThemeCGColorPicker(colors: "#FFFFFF", "#000")
ThemeCGColorPicker(colors: UIColor.red, UIColor.blue)
ThemeCGColorPicker(colors: UIColor.red.cgColor, UIColor.blue.cgColor)
ThemeCGColorPicker.pickerWithColors(["#FFFFFF", "#000"])
ThemeCGColorPicker.pickerWithUIColors([UIColor.blue, UIColor.red])
②
ThemeCGColorPicker(keyPath: "someStringKeyPath")
ThemeCGColorPicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeFontPicker
```swift
①
ThemeFontPicker(fonts: UIFont.systemFont(ofSize: 10), UIFont.systemFont(ofSize: 11))
ThemeFontPicker.pickerWithFonts([UIFont.systemFont(ofSize: 10), UIFont.systemFont(ofSize: 11)])
②
// name the key you like, but the available values format like this: "PingFangSC-Regular,16"
ThemeFontPicker(keyPath: "someStringKeyPath")
ThemeFontPicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeDictionaryPicker
```swift
①
ThemeDictionaryPicker(dicts: ["key": "value"], ["key": "value"])
ThemeDictionaryPicker.pickerWithDicts([["key": "value"], ["key": "value"]])
②
ThemeDictionaryPicker(keyPath: "someStringKeyPath") { (Any?) -> [String: AnyObject]? in ... }
```

#### ThemeStringAttributesPicker
```swift
①
ThemeStringAttributesPicker(["key": "value"], ["key": "value"])
ThemeStringAttributesPicker.pickerWithAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)])
②
ThemeStringAttributesPicker(keyPath: "someStringKeyPath") { (Any?) -> [NSAttributedString.Key: Any]? in ... }
```

#### ThemeAttributedStringPicker
```swift
①
ThemeAttributedStringPicker(NSAttributedString(...), NSAttributedString(...))
ThemeAttributedStringPicker.pickerWithAttributedStrings([NSAttributedString(...)])
②
ThemeAttributedStringPicker(keyPath: "someStringKeyPath") { (Any?) -> NSAttributedString? in ... }
```

#### ThemeBarStylePicker
```swift
①
ThemeBarStylePicker(styles: .default, .black)
ThemeBarStylePicker.pickerWithStyles([.default, .black])
ThemeBarStylePicker.pickerWithStringStyles(["default", "black"])
②
// name the key you like, but the available values are "default" and "black"
ThemeBarStylePicker(keyPath: "someStringKeyPath")
ThemeBarStylePicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeStatusBarStylePicker
```swift
①
ThemeStatusBarStylePicker(styles: .default, .lightContent, .darkContent)
ThemeStatusBarStylePicker.pickerWithStyles([.default, .lightContent, .darkContent])
ThemeStatusBarStylePicker.pickerWithStringStyles(["default", "lightContent", "darkContent"])
②
// name the key you like, but the available values are "default", "lightContent" and "darkContent"
ThemeStatusBarStylePicker(keyPath: "someStringKeyPath")
ThemeStatusBarStylePicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeKeyboardAppearancePicker
```swift
①
ThemeKeyboardAppearancePicker(styles: .default, .dark, .light)
ThemeKeyboardAppearancePicker.pickerWithStyles([.default, .dark, .light])
ThemeKeyboardAppearancePicker.pickerWithStringStyles(["default", "dark", "light"])
②
// name the key you like, but the available values are "default", "dark" and "light"
ThemeKeyboardAppearancePicker(keyPath: "someStringKeyPath")
ThemeKeyboardAppearancePicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeActivityIndicatorViewStylePicker
```swift
①
ThemeActivityIndicatorViewStylePicker(styles: .whiteLarge, .white, .gray)
ThemeActivityIndicatorViewStylePicker.pickerWithStyles([.whiteLarge, .white, .gray])
ThemeActivityIndicatorViewStylePicker.pickerWithStringStyles(["whiteLarge", "white", "gray"])
②
// name the key you like, but the available values are "whiteLarge", "white" and "gray"
ThemeActivityIndicatorViewStylePicker(keyPath: "someStringKeyPath")
ThemeActivityIndicatorViewStylePicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeVisualEffectPicker
```swift
①
ThemeVisualEffectPicker(effects: UIBlurEffect(style: .light), UIBlurEffect(style: .dark))
ThemeVisualEffectPicker.pickerWithEffects([UIBlurEffect(style: .light), UIBlurEffect(style: .dark)])
ThemeVisualEffectPicker.pickerWithStringEffects(["light", "dark", "extralight", "prominent", "regular"])
②
// name the key you like, but the available values are "light", "dark", "extralight", "prominent" and "regular"
ThemeVisualEffectPicker(keyPath: "someStringKeyPath")
ThemeVisualEffectPicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeAnyPicker
```swift
①
ThemeAnyPicker(anys: 0, "123", UIColor.red)
ThemeAnyPicker.pickerWithAnys([0, "123", UIColor.red])
②
ThemeAnyPicker(keyPath: "someStringKeyPath")
ThemeAnyPicker.pickerWithKeyPath("someStringKeyPath")
```

### *More*

Download this project and find more. There are four demo targets:

- `Demo` shows how to use index mode and how to save the last selection of themes and other general usages.
- `PlistDemo` shows how to use plist mode and how to download themes that packaged in zip files.
- `JsonDemo` is like `PlistDemo`, but use `json`.
- `OCDemo` is `Demo`'s Objective-C version.
- `TVOSDemo` is used to test tvos compatibility.

## FAQ

1.  Why doesn't theme_setStatusBarStyle work as expected?

    In your app's `Info.plist` you will need to set `View Controller-based status bar appearence` to `NO`.
    
2.  Can I manually cancel the theme of a property?

    Sure, just make it `nil`—example: `view.theme_backgroundColor = nil`.

## Contribution

### Issue
If you find a bug or need a help, you can [create a issue](https://github.com/wxxsw/SwiftTheme/issues/new)


### Pull Request
We are happy to accept pull requests :D. But please make sure it's needed by most developers and make it simple to use. If you are not sure, create an issue and we can discuss it before you get to coding.

### Contributors
[Gesen](https://github.com/wxxsw), [Zhoujun](https://github.com/shannonchou), [Kevin Cramer](https://github.com/kcramer)


## Lisence

The MIT License (MIT)
