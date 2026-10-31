![SwiftTheme](https://raw.githubusercontent.com/wxxsw/SwiftThemeResources/master/Screenshots/logo.png)

<p align="center">
<a href="#前言">前言</a> -
<a href="#示例">示例</a> -
<a href="#安装">安装</a> -
<a href="#参考">参考</a> -
<a href="#常见问题">常见问题</a> -
<a href="#贡献">贡献</a> -
<a href="README.md">English Document</a>
</p>

<p align="center">
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/language-swift5-f48041.svg?style=flat"></a>
<a href="http://cocoadocs.org/docsets/SwiftTheme"><img src="https://img.shields.io/cocoapods/v/SwiftTheme.svg?style=flat"></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat"></a>
<a href="https://developer.apple.com/ios"><img src="https://img.shields.io/badge/platform-iOS%209%2B | tvOS%209%2B-blue.svg?style=flat"></a>
<a href="https://github.com/wxxsw/SwiftTheme/blob/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat"></a>
</p>

常见配置示例与兼容性限制：[主题配置说明（英文）](docs/UsageNotes.md)。

## 截屏

![](https://github.com/wxxsw/SwiftThemeResources/blob/master/Screenshots/switch.gif)

> 运行：打开`SwiftTheme.xcworkspace`选择构建目标为`PlistDemo`

## 前言
### 缘起
项目需求，我们要为 App 开发夜间模式功能。我们的需求不是简单的调整亮度或者`alpha`，而是更换为一套更深色的UI。因此所谓夜间模式其实就是特定的更换主题（换肤）功能。

如何实现呢？判断某个全局变量，然后在初始化视图控件时设置不同的背景色或者加载不同的切图文件？但是在切换主题时，已经初始化好的视图控件呢？没错，也许你也想到了通过通知让相应的视图控件修改背景色或切图。想到这里你应该也意识到了Controller中将充斥着注册通知、`if...else`、更新视图控件的代码，糟糕的是如果忘记了注销通知还可能引起应用崩溃。

一番思考后，我们对该任务提出了更高的要求，打造一套简单、可复用的主题框架，正如你看到的这样。

### 目标
将`SwiftTheme`打造为一款简单、功能丰富、高性能、可扩展的主题框架（换肤框架），为 iOS 平台提供一个统一的主题解决方案。

## 示例

### 索引方式

让 `UIView` 随主题变换背景色：

```swift
view.theme_backgroundColor = ["#FFF", "#000"]
```

让 `UILabel` 和 `UIButton` 随主题变换文字颜色：

```swift
label.theme_textColor = ["#000", "#FFF"]
button.theme_setTitleColor(["#000", "#FFF"], forState: .Normal)
```

让 `UIImageView` 随主题变换切图：

```swift
imageView.theme_image = ["day", "night"]

// 不想通过切图名，想通过 UIImage 来设置不同主题的图片也是可以的
imageView.theme_image = ThemeImagePicker(images: image1, image2)
```

然后，当你执行如下代码时，奇迹发生了！

```swift
// 例如isNight为true，imageView将会使用 "night" 的切图
ThemeManager.setTheme(index: isNight ? 1 : 0)
```

随时获取当前主题的索引：

```swift
ThemeManager.currentThemeIndex	// Readonly
```

> 直接根据索引切换主题，便于快速开发。适合主题不多、无需下载主题的App。

关于字面量需要注意的：

```swift
// 以下的写法是错误的
let colors = ["#FFF", "#000"]
view.theme_backgroundColor = colors

// 应该这样
view.theme_backgroundColor = ["#FFF", "#000"]
// 或者
let colorPickers: ThemeColorPicker = ["#FFF", "#000"]
view.theme_backgroundColor = colorPickers
```

> 因为 theme_backgroundColor 接受的是ThemeColorPicker 类型的参数，而不是Array，而 view.theme_backgroundColor = ["#FFF", "#000"] 其实是用字面量初始化一个ThemeColorPicker 并赋值给theme_backgroundColor




### plist 方式
为了满足通过网络下载和安装主题包的需求，我们支持以`plist`配置主题。简单讲就是在`plist` 中记录配置参数，比如背景色、切图文件名等，在代码中通过`keyPath`来指定相应的位置。因此，该`plist`文件以及用到的资源文件就组成了一个主题包。

以下为用法示例：

```swift
view.theme_backgroundColor = "Global.backgroundColor"
imageView.theme_image = "SelectedThemeCell.iconImage"
```
> 与索引方式类似，只是具体的参数值变为了`plist`中的`keyPath`，正因如此赋予了它扩展的能力。


切换主题时参数为`plist`名称，这里以`bundle`中的`plist`文件及资源文件为例，使用沙箱中的文件也是可以的。

```swift
ThemeManager.setTheme(plistName: "Red", path: .MainBundle)
```

> `plist`方式增加主题无需修改代码，可以无限扩展主题，因此你完全可以通过这种方式为你的用户开发下载安装主题的功能。

上面用到的`plist`、`image`展示如下：

![](https://github.com/wxxsw/SwiftThemeResources/blob/master/Screenshots/1.pic.jpg)
![](https://github.com/wxxsw/SwiftThemeResources/blob/master/Screenshots/2.pic.jpg)


### 自定义行为

如果你想在切换主题时执行自定义任务，或者当`SwiftTheme`无法满足你的需求时，可以注册名为`ThemeUpdateNotification`的通知，你可以在任何地方观察这个通知，来实现自定义的行为：
```swift
NSNotificationCenter.default.addObserver(
	self, 
	selector: #selector(doSomethingMethod),
	name: NSNotification.Name(rawValue: ThemeUpdateNotification), 
	object: nil
)
```
```objective-c
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething) name:@"ThemeUpdateNotification" object:nil];
```

### Objective-C
完全兼容Objective-C，用法示例：

```objective-c
lbl.theme_backgroundColor = [ThemeColorPicker pickerWithColors:@[@"#FAF9F9", @"#E2E2E2"]];
```

### 主要特点
- [x] 纯Swift编写
- [x] 兼容Objective-C
- [x] 基于`runtime`
- [x] 易于集成
- [x] 扩展属性以 `theme_*` 开头，便于 IDE 自动补全
- [x] 支持`UIAppearance`
- [x] 自动监听主题切换，更新UI
- [x] 支持通过字面量设置不同主题，通过索引进行切换
- [x] 支持使用`plist`设置主题，可直接通过项目资源加载，或远程下载至沙盒中加载
- [x] 主题参数配置错误时日志提示
- [x] 强类型`ThemePicker`
- [x] 完整的Demo


## 安装

#### CocoaPods
```swift
pod 'SwiftTheme'
use_frameworks!
```

#### Carthage
```swift
github "wxxsw/SwiftTheme"
```

#### 源文件
拷贝`Source`文件夹下的所有文件到你的项目中

## 参考

### *目前支持的属性*
***

> 子类会拥有父类的属性，例如`UILabel`也会拥有`UIView`的`theme_alpha`等属性，这种属性不一一列出

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

##### CAGradientLayer
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
// 目前支持的颜色格式有：
// "#ffcc00"		RGB十六进制 
// "#ffcc00dd"		+alpha
// "#FFF"			RGB十六进制缩写
// "#013E"			+alpha
①
ThemeColorPicker(colors: "#FFFFFF", "#000")
ThemeColorPicker(colors: UIColor.red, UIColor.blue)
ThemeColorPicker(colors: "#FFFFFF", "#000")
ThemeColorPicker.pickerWithColors(["#FFFFFF", "#000"])
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
ThemeCGColorPicker(colors: "#FFFFFF", "#000")
ThemeCGColorPicker.pickerWithColors(["#FFFFFF", "#000"])
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
// 格式示例 "PingFangSC-Regular,16"
ThemeFontPicker(keyPath: "someStringKeyPath")
ThemeFontPicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeDictionaryPicker
```swift
①
ThemeDictionaryPicker(dicts: ["key": "value"], ["key": "value"])
ThemeDictionaryPicker.pickerWithDicts([["key": "value"], ["key": "value"]])
ThemeDictionaryPicker.pickerWithAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)])
②
ThemeBarStylePicker(keyPath: "someStringKeyPath") { (Any?) -> [String: AnyObject]? in ... }
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
// 在自定的`Key`中设置指定的`Value`，匹配字符串即可生效
// 可选的值有："default" 和 "black"
ThemeBarStylePicker(keyPath: "someStringKeyPath")
ThemeBarStylePicker.pickerWithKeyPath("someStringKeyPath")
```

#### ThemeStatusBarStylePicker
```swift
①
ThemeStatusBarStylePicker(styles: .default, .lightContent)
ThemeStatusBarStylePicker.pickerWithStyles([.default, .lightContent])
ThemeStatusBarStylePicker.pickerWithStringStyles(["default", "lightContent"])
②
// 在自定的`Key`中设置指定的`Value`，匹配字符串即可生效
// 可选的值有："default" 和 "lightContent"
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
// 在自定的`Key`中设置指定的`Value`，匹配字符串即可生效
// 可选的值有："default"、"dark" 和 "light"
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
// 在自定的`Key`中设置指定的`Value`，匹配字符串即可生效
// 可选的值有："whiteLarge"、"white" 和 "gray"
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
// 在自定的`Key`中设置指定的`Value`，匹配字符串即可生效
// 可选的值有："light"、"dark"、"prominent" 和 "regular"
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

### *更多*

下载`SwiftTheme`项目，了解如何在项目中使用，其中包含四个Demo Target：

- `Demo`演示了如何使用索引进行管理，退出时保存上次使用的主题等常见需求
- `PlistDemo`演示了如何使用`plist`进行管理，并包含下载保存主题Zip包等功能
- `JsonDemo` 类似 `PlistDemo`, 但是使用 `json`.
- `OCDemo` 是 `Demo` 的 Objective-C 版本.
- `TVOSDemo` 用来测试 tvOS 的兼容性.

## 常见问题

1.  使用theme_setStatusBarStyle设置状态栏样式时没有任何效果，为什么？

    答：你需要将`Info.plist`中的`View Controller-based status bar appearence`设置为`NO`。

2.  我可以手动取消某个属性的主题吗？

    答：可以，传入`nil`即可，例如 `view.theme_backgroundColor = nil`。

## 贡献

### Issue
如果你需要帮助或者遇到Bug，请[创建一个Issue](https://github.com/wxxsw/SwiftTheme/issues/new)

### Pull Request
期待你的贡献 :D。但是请确保你添加的功能不要偏离主旨，并保证其足够简单易用，如果你不确定可以先通过issue与我们讨论。

### Contributors
[Gesen](https://github.com/wxxsw), [Zhoujun](https://github.com/shannonchou)


## Lisence

The MIT License (MIT)
