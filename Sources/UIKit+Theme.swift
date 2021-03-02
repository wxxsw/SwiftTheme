//
//  UIKit+Theme.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/22.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

public class XTTheme<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ThemeCompatible {
    associatedtype ThemeBase
    var theme: XTTheme<ThemeBase> {get set}
}

extension ThemeCompatible {
    public var theme: XTTheme<Self> {
        get {XTTheme(self)}
        set {}
    }
}

extension NSObject: ThemeCompatible {}

extension XTTheme where Base: UIView {
    public var alpha: ThemeCGFloatPicker? {
        get { return getThemePicker(base, "setAlpha:") as? ThemeCGFloatPicker }
         set { setThemePicker(base, "setAlpha:", newValue) }
    }
    
    public var backgroundColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBackgroundColor:", newValue) }
    }
    
    public func setBackgroundColor(_ color: ThemeColorPicker?) {
        setThemePicker(base, "setBackgroundColor:", color)
    }
    public var tintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTintColor:", newValue) }
    }
}

extension XTTheme where Base: UIApplication {
    #if os(iOS)
    public func setStatusBarStyle(_ picker: ThemeStatusBarStylePicker, animated: Bool) {
        picker.animated = animated
        setThemePicker(base, "setStatusBarStyle:animated:", picker)
    }
    #endif
}
extension XTTheme where Base: UIBarItem {
    public var image: ThemeImagePicker? {
        get { return getThemePicker(base, "setImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setImage:", newValue) }
    }
    public func setTitleTextAttributes(_ picker: ThemeStringAttributesPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setTitleTextAttributes:forState:", picker, state)
        setThemePicker(base, "setTitleTextAttributes:forState:", statePicker)
    }
}
extension XTTheme where Base: UIBarButtonItem {
    public var tintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTintColor:", newValue) }
    }
}
extension XTTheme where Base: UILabel {
    public var font: ThemeFontPicker? {
        get { return getThemePicker(base, "setFont:") as? ThemeFontPicker }
        set { setThemePicker(base, "setFont:", newValue) }
    }
    public var textColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTextColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTextColor:", newValue) }
    }
    public var highlightedTextColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setHighlightedTextColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setHighlightedTextColor:", newValue) }
    }
    public var shadowColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setShadowColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setShadowColor:", newValue) }
    }
    public var textAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "updateTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "updateTextAttributes:", newValue) }
    }
    public var attributedText: ThemeAttributedStringPicker? {
        get { return getThemePicker(base, "setAttributedText:") as? ThemeAttributedStringPicker }
        set { setThemePicker(base, "setAttributedText:", newValue) }
    }
}
extension XTTheme where Base: UINavigationBar {
    #if os(iOS)
    public var barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(base, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(base, "setBarStyle:", newValue) }
    }
    #endif
    public var barTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBarTintColor:", newValue) }
    }
    public var titleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "setTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "setTitleTextAttributes:", newValue) }
    }
    public var largeTitleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "setLargeTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "setLargeTitleTextAttributes:", newValue) }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    public var standardAppearance: ThemeNavigationBarAppearancePicker? {
        get { return getThemePicker(base, "setStandardAppearance:") as? ThemeNavigationBarAppearancePicker }
        set { setThemePicker(base, "setStandardAppearance:", newValue) }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    public var compactAppearance: ThemeNavigationBarAppearancePicker? {
        get { return getThemePicker(base, "setCompactAppearance:") as? ThemeNavigationBarAppearancePicker }
        set { setThemePicker(base, "setCompactAppearance:", newValue) }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    public var scrollEdgeAppearance: ThemeNavigationBarAppearancePicker? {
        get { return getThemePicker(base, "setScrollEdgeAppearance:") as? ThemeNavigationBarAppearancePicker }
        set { setThemePicker(base, "setScrollEdgeAppearance:", newValue) }
    }
}
extension XTTheme where Base: UITabBar {
    #if os(iOS)
    public var barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(base, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(base, "setBarStyle:", newValue) }
    }
    #endif
    public var unselectedItemTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setUnselectedItemTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setUnselectedItemTintColor:", newValue) }
    }
    public var barTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBarTintColor:", newValue) }
    }
}
extension XTTheme where Base: UITabBarItem {
    public var selectedImage: ThemeImagePicker? {
        get { return getThemePicker(base, "setSelectedImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setSelectedImage:", newValue) }
    }
}
extension XTTheme where Base: UITableView {
    public var separatorColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setSeparatorColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setSeparatorColor:", newValue) }
    }
    public var sectionIndexColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setSectionIndexColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setSectionIndexColor:", newValue) }
    }
    public var sectionIndexBackgroundColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setSectionIndexBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setSectionIndexBackgroundColor:", newValue) }
    }
}
extension XTTheme where Base: UITextField {
    public var font: ThemeFontPicker? {
        get { return getThemePicker(base, "setFont:") as? ThemeFontPicker }
        set { setThemePicker(base, "setFont:", newValue) }
    }
    public var keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { return getThemePicker(base, "setKeyboardAppearance:") as? ThemeKeyboardAppearancePicker }
        set { setThemePicker(base, "setKeyboardAppearance:", newValue) }
    }
    public var textColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTextColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTextColor:", newValue) }
    }
    public var placeholderAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "updatePlaceholderAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "updatePlaceholderAttributes:", newValue) }
    }
}
extension XTTheme where Base: UITextView {
    public var font: ThemeFontPicker? {
        get { return getThemePicker(base, "setFont:") as? ThemeFontPicker }
        set { setThemePicker(base, "setFont:", newValue) }
    }
    public var keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { return getThemePicker(base, "setKeyboardAppearance:") as? ThemeKeyboardAppearancePicker }
        set { setThemePicker(base, "setKeyboardAppearance:", newValue) }
    }
    public var textColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTextColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTextColor:", newValue) }
    }
}
extension XTTheme where Base: UISearchBar {
    #if os(iOS)
    public var barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(base, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(base, "setBarStyle:", newValue) }
    }
    #endif
    public var keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { return getThemePicker(base, "setKeyboardAppearance:") as? ThemeKeyboardAppearancePicker }
        set { setThemePicker(base, "setKeyboardAppearance:", newValue) }
    }
    public var barTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBarTintColor:", newValue) }
    }
}
extension XTTheme where Base: UIProgressView {
    public var progressTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setProgressTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setProgressTintColor:", newValue) }
    }
    public var trackTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTrackTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTrackTintColor:", newValue) }
    }
}
extension XTTheme where Base: UIPageControl {
    public var pageIndicatorTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setPageIndicatorTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setPageIndicatorTintColor:", newValue) }
    }
    public var currentPageIndicatorTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setCurrentPageIndicatorTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setCurrentPageIndicatorTintColor:", newValue) }
    }
}
extension XTTheme where Base: UIImageView {
    public var image: ThemeImagePicker? {
        get { return getThemePicker(base, "setImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setImage:", newValue) }
    }
}
extension XTTheme where Base: UIActivityIndicatorView {
    public var color: ThemeColorPicker? {
        get { return getThemePicker(base, "setColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setColor:", newValue) }
    }
    public var activityIndicatorViewStyle: ThemeActivityIndicatorViewStylePicker? {
        get { return getThemePicker(base, "setActivityIndicatorViewStyle:") as? ThemeActivityIndicatorViewStylePicker }
        set { setThemePicker(base, "setActivityIndicatorViewStyle:", newValue) }
    }
}
extension XTTheme where Base: UIScrollView {
    public var indicatorStyle: ThemeScrollViewIndicatorStylePicker? {
        get { return getThemePicker(base, "setIndicatorStyle:") as? ThemeScrollViewIndicatorStylePicker }
        set { setThemePicker(base, "setIndicatorStyle:", newValue) }
    }
}
extension XTTheme where Base: UIButton {
    public func setImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setImage:forState:", picker, state)
        setThemePicker(base, "setImage:forState:", statePicker)
    }
    public func setBackgroundImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setBackgroundImage:forState:", picker, state)
        setThemePicker(base, "setBackgroundImage:forState:", statePicker)
    }
    public func setTitleColor(_ picker: ThemeColorPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setTitleColor:forState:", picker, state)
        setThemePicker(base, "setTitleColor:forState:", statePicker)
    }
    public func setAttributedTitle(_ picker: ThemeAttributedStringPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setAttributedTitle:forState:", picker, state)
        setThemePicker(base, "setAttributedTitle:forState:", statePicker)
    }
}
extension XTTheme where Base: CALayer {
    public var backgroundColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setBackgroundColor:") as? ThemeCGColorPicker}
        set { setThemePicker(base, "setBackgroundColor:", newValue) }
    }
    public var borderWidth: ThemeCGFloatPicker? {
        get { return getThemePicker(base, "setBorderWidth:") as? ThemeCGFloatPicker }
        set { setThemePicker(base, "setBorderWidth:", newValue) }
    }
    public var borderColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setBorderColor:") as? ThemeCGColorPicker }
        set { setThemePicker(base, "setBorderColor:", newValue) }
    }
    public var shadowColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setShadowColor:") as? ThemeCGColorPicker }
        set { setThemePicker(base, "setShadowColor:", newValue) }
    }
    public var strokeColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setStrokeColor:") as? ThemeCGColorPicker }
        set { setThemePicker(base, "setStrokeColor:", newValue) }
    }
    public var fillColor: ThemeCGColorPicker?{
        get { return getThemePicker(base, "setFillColor:") as? ThemeCGColorPicker }
        set { setThemePicker(base, "setFillColor:", newValue) }
    }
}
extension XTTheme where Base: CATextLayer {
    public var foregroundColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setForegroundColor:") as? ThemeCGColorPicker}
        set { setThemePicker(base, "setForegroundColor:", newValue) }
    }
}
extension XTTheme where Base: CAGradientLayer {
    public var colors: ThemeAnyPicker? {
        get { return getThemePicker(base, "setColors:") as? ThemeAnyPicker }
        set { setThemePicker(base, "setColors:", newValue) }
    }
}

#if os(iOS)
extension XTTheme where Base: UIToolbar {
    public var barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(base, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(base, "setBarStyle:", newValue) }
    }
    public var barTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBarTintColor:", newValue) }
    }
}
extension XTTheme where Base: UISegmentedControl {
    public var selectedSegmentTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setSelectedSegmentTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setSelectedSegmentTintColor:", newValue) }
    }
    public func setTitleTextAttributes(_ picker: ThemeStringAttributesPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setTitleTextAttributes:forState:", picker, state)
        setThemePicker(base, "setTitleTextAttributes:forState:", statePicker)
    }
}
extension XTTheme where Base: UISwitch {
    public var onTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setOnTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setOnTintColor:", newValue) }
    }
    public var thumbTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setThumbTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setThumbTintColor:", newValue) }
    }
}
extension XTTheme where Base: UISlider {
    public var thumbTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setThumbTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setThumbTintColor:", newValue) }
    }
    public var minimumTrackTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setMinimumTrackTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setMinimumTrackTintColor:", newValue) }
    }
    public var maximumTrackTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setMaximumTrackTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setMaximumTrackTintColor:", newValue) }
    }
}
extension XTTheme where Base: UIPopoverPresentationController {
    public var backgroundColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBackgroundColor:", newValue) }
    }
}
extension XTTheme where Base: UIRefreshControl {
    public var titleAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "updateTitleAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "updateTitleAttributes:", newValue) }
    }
}
extension XTTheme where Base: UIVisualEffectView {
    public var effect: ThemeVisualEffectPicker? {
        get { return getThemePicker(base, "setEffect:") as? ThemeVisualEffectPicker }
        set { setThemePicker(base, "setEffect:", newValue) }
    }
}
@available(iOS 13.0, *)
extension XTTheme where Base: UINavigationBarAppearance {
    public var titleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "setTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "setTitleTextAttributes:", newValue) }
    }
    public var largeTitleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "setLargeTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "setLargeTitleTextAttributes:", newValue) }
    }
    public var backIndicatorImage: ThemeImagePicker? {
        get { return getThemePicker(base, "setBackIndicatorImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setBackIndicatorImage:", newValue) }
    }
}
@available(iOS 13.0, *)
extension XTTheme where Base: UIBarAppearance {
    public var backgroundColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBackgroundColor:", newValue) }
    }
    public var backgroundImage: ThemeImagePicker? {
        get { return getThemePicker(base, "setBackgroundImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setBackgroundImage:", newValue) }
    }
    public var backgroundEffect: ThemeBlurEffectPicker? {
        get { return getThemePicker(base, "setBackgroundEffect:") as? ThemeBlurEffectPicker }
        set { setThemePicker(base, "setBackgroundEffect:", newValue) }
    }
    public var shadowColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setShadowColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setShadowColor:", newValue) }
    }
    public var shadowImage: ThemeImagePicker? {
        get { return getThemePicker(base, "setShadowImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setShadowImage:", newValue) }
    }
}
#endif

private func getThemePicker(
    _ object : NSObject,
    _ selector : String
) -> ThemePicker? {
    return ThemePicker.getThemePicker(object, selector)
}

private func setThemePicker(
    _ object : NSObject,
    _ selector : String,
    _ picker : ThemePicker?
) {
    return ThemePicker.setThemePicker(object, selector, picker)
}

private func makeStatePicker(
    _ object : NSObject,
    _ selector : String,
    _ picker : ThemePicker?,
    _ state : UIControl.State
) -> ThemePicker? {
    return ThemePicker.makeStatePicker(object, selector, picker, state)
}
