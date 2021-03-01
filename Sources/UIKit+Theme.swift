//
//  UIKit+Theme.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/22.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

public struct XTTheme<Base> {
    let base: Base
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
    var alpha: ThemeCGFloatPicker? {
        get { return getThemePicker(base, "setAlpha:") as? ThemeCGFloatPicker }
        set { setThemePicker(base, "setAlpha:", newValue) }
    }
    var backgroundColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBackgroundColor:", newValue) }
    }
    var tintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTintColor:", newValue) }
    }
}

extension XTTheme where Base: UIApplication
{
    #if os(iOS)
    func theme_setStatusBarStyle(_ picker: ThemeStatusBarStylePicker, animated: Bool) {
        picker.animated = animated
        setThemePicker(base, "setStatusBarStyle:animated:", picker)
    }
    #endif
}
extension XTTheme where Base: UIBarItem
{
    var image: ThemeImagePicker? {
        get { return getThemePicker(base, "setImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setImage:", newValue) }
    }
    func setTitleTextAttributes(_ picker: ThemeStringAttributesPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setTitleTextAttributes:forState:", picker, state)
        setThemePicker(base, "setTitleTextAttributes:forState:", statePicker)
    }
}
extension XTTheme where Base: UIBarButtonItem
{
    var tintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTintColor:", newValue) }
    }
}
extension XTTheme where Base: UILabel
{
    var font: ThemeFontPicker? {
        get { return getThemePicker(base, "setFont:") as? ThemeFontPicker }
        set { setThemePicker(base, "setFont:", newValue) }
    }
    var textColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTextColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTextColor:", newValue) }
    }
    var highlightedTextColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setHighlightedTextColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setHighlightedTextColor:", newValue) }
    }
    var shadowColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setShadowColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setShadowColor:", newValue) }
    }
    var textAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "updateTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "updateTextAttributes:", newValue) }
    }
    var attributedText: ThemeAttributedStringPicker? {
        get { return getThemePicker(base, "setAttributedText:") as? ThemeAttributedStringPicker }
        set { setThemePicker(base, "setAttributedText:", newValue) }
    }
}
extension XTTheme where Base: UINavigationBar
{
    #if os(iOS)
    var barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(base, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(base, "setBarStyle:", newValue) }
    }
    #endif
    var barTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBarTintColor:", newValue) }
    }
    var titleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "setTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "setTitleTextAttributes:", newValue) }
    }
    var largeTitleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "setLargeTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "setLargeTitleTextAttributes:", newValue) }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var standardAppearance: ThemeNavigationBarAppearancePicker? {
        get { return getThemePicker(base, "setStandardAppearance:") as? ThemeNavigationBarAppearancePicker }
        set { setThemePicker(base, "setStandardAppearance:", newValue) }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var compactAppearance: ThemeNavigationBarAppearancePicker? {
        get { return getThemePicker(base, "setCompactAppearance:") as? ThemeNavigationBarAppearancePicker }
        set { setThemePicker(base, "setCompactAppearance:", newValue) }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var scrollEdgeAppearance: ThemeNavigationBarAppearancePicker? {
        get { return getThemePicker(base, "setScrollEdgeAppearance:") as? ThemeNavigationBarAppearancePicker }
        set { setThemePicker(base, "setScrollEdgeAppearance:", newValue) }
    }
}
extension XTTheme where Base: UITabBar
{
    #if os(iOS)
    var barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(base, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(base, "setBarStyle:", newValue) }
    }
    #endif
    var unselectedItemTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setUnselectedItemTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setUnselectedItemTintColor:", newValue) }
    }
    var barTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBarTintColor:", newValue) }
    }
}
extension XTTheme where Base: UITabBarItem
{
    var selectedImage: ThemeImagePicker? {
        get { return getThemePicker(base, "setSelectedImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setSelectedImage:", newValue) }
    }
}
extension XTTheme where Base: UITableView
{
    var separatorColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setSeparatorColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setSeparatorColor:", newValue) }
    }
    var sectionIndexColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setSectionIndexColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setSectionIndexColor:", newValue) }
    }
    var sectionIndexBackgroundColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setSectionIndexBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setSectionIndexBackgroundColor:", newValue) }
    }
}
extension XTTheme where Base: UITextField
{
    var font: ThemeFontPicker? {
        get { return getThemePicker(base, "setFont:") as? ThemeFontPicker }
        set { setThemePicker(base, "setFont:", newValue) }
    }
    var keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { return getThemePicker(base, "setKeyboardAppearance:") as? ThemeKeyboardAppearancePicker }
        set { setThemePicker(base, "setKeyboardAppearance:", newValue) }
    }
    var textColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTextColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTextColor:", newValue) }
    }
    var placeholderAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "updatePlaceholderAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "updatePlaceholderAttributes:", newValue) }
    }
}
extension XTTheme where Base: UITextView
{
    var font: ThemeFontPicker? {
        get { return getThemePicker(base, "setFont:") as? ThemeFontPicker }
        set { setThemePicker(base, "setFont:", newValue) }
    }
    var keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { return getThemePicker(base, "setKeyboardAppearance:") as? ThemeKeyboardAppearancePicker }
        set { setThemePicker(base, "setKeyboardAppearance:", newValue) }
    }
    var textColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTextColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTextColor:", newValue) }
    }
}
extension XTTheme where Base: UISearchBar
{
    #if os(iOS)
    var barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(base, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(base, "setBarStyle:", newValue) }
    }
    #endif
    var keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { return getThemePicker(base, "setKeyboardAppearance:") as? ThemeKeyboardAppearancePicker }
        set { setThemePicker(base, "setKeyboardAppearance:", newValue) }
    }
    var barTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBarTintColor:", newValue) }
    }
}
extension XTTheme where Base: UIProgressView
{
    var progressTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setProgressTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setProgressTintColor:", newValue) }
    }
    var trackTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setTrackTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setTrackTintColor:", newValue) }
    }
}
extension XTTheme where Base: UIPageControl
{
    var pageIndicatorTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setPageIndicatorTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setPageIndicatorTintColor:", newValue) }
    }
    var currentPageIndicatorTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setCurrentPageIndicatorTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setCurrentPageIndicatorTintColor:", newValue) }
    }
}
extension XTTheme where Base: UIImageView
{
    var image: ThemeImagePicker? {
        get { return getThemePicker(base, "setImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setImage:", newValue) }
    }
}
extension XTTheme where Base: UIActivityIndicatorView
{
    var color: ThemeColorPicker? {
        get { return getThemePicker(base, "setColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setColor:", newValue) }
    }
    var activityIndicatorViewStyle: ThemeActivityIndicatorViewStylePicker? {
        get { return getThemePicker(base, "setActivityIndicatorViewStyle:") as? ThemeActivityIndicatorViewStylePicker }
        set { setThemePicker(base, "setActivityIndicatorViewStyle:", newValue) }
    }
}
extension XTTheme where Base: UIScrollView
{
    var indicatorStyle: ThemeScrollViewIndicatorStylePicker? {
        get { return getThemePicker(base, "setIndicatorStyle:") as? ThemeScrollViewIndicatorStylePicker }
        set { setThemePicker(base, "setIndicatorStyle:", newValue) }
    }
}
extension XTTheme where Base: UIButton
{
    func setImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setImage:forState:", picker, state)
        setThemePicker(base, "setImage:forState:", statePicker)
    }
    func setBackgroundImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setBackgroundImage:forState:", picker, state)
        setThemePicker(base, "setBackgroundImage:forState:", statePicker)
    }
    func setTitleColor(_ picker: ThemeColorPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setTitleColor:forState:", picker, state)
        setThemePicker(base, "setTitleColor:forState:", statePicker)
    }
    func setAttributedTitle(_ picker: ThemeAttributedStringPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setAttributedTitle:forState:", picker, state)
        setThemePicker(base, "setAttributedTitle:forState:", statePicker)
    }
}
extension XTTheme where Base: CALayer
{
    var backgroundColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setBackgroundColor:") as? ThemeCGColorPicker}
        set { setThemePicker(base, "setBackgroundColor:", newValue) }
    }
    var borderWidth: ThemeCGFloatPicker? {
        get { return getThemePicker(base, "setBorderWidth:") as? ThemeCGFloatPicker }
        set { setThemePicker(base, "setBorderWidth:", newValue) }
    }
    var borderColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setBorderColor:") as? ThemeCGColorPicker }
        set { setThemePicker(base, "setBorderColor:", newValue) }
    }
    var shadowColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setShadowColor:") as? ThemeCGColorPicker }
        set { setThemePicker(base, "setShadowColor:", newValue) }
    }
    var strokeColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setStrokeColor:") as? ThemeCGColorPicker }
        set { setThemePicker(base, "setStrokeColor:", newValue) }
    }
    var fillColor: ThemeCGColorPicker?{
        get { return getThemePicker(base, "setFillColor:") as? ThemeCGColorPicker }
        set { setThemePicker(base, "setFillColor:", newValue) }
    }
}
extension XTTheme where Base: CATextLayer
{
    var foregroundColor: ThemeCGColorPicker? {
        get { return getThemePicker(base, "setForegroundColor:") as? ThemeCGColorPicker}
        set { setThemePicker(base, "setForegroundColor:", newValue) }
    }
}
extension XTTheme where Base: CAGradientLayer
{
    var colors: ThemeAnyPicker? {
        get { return getThemePicker(base, "setColors:") as? ThemeAnyPicker }
        set { setThemePicker(base, "setColors:", newValue) }
    }
}

#if os(iOS)
extension XTTheme where Base: UIToolbar
{
    var barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(base, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(base, "setBarStyle:", newValue) }
    }
    var barTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBarTintColor:", newValue) }
    }
}
extension XTTheme where Base: UISegmentedControl
{
    var selectedSegmentTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setSelectedSegmentTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setSelectedSegmentTintColor:", newValue) }
    }
    func setTitleTextAttributes(_ picker: ThemeStringAttributesPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(base, "setTitleTextAttributes:forState:", picker, state)
        setThemePicker(base, "setTitleTextAttributes:forState:", statePicker)
    }
}
extension XTTheme where Base: UISwitch
{
    var onTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setOnTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setOnTintColor:", newValue) }
    }
    var thumbTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setThumbTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setThumbTintColor:", newValue) }
    }
}
extension XTTheme where Base: UISlider
{
    var thumbTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setThumbTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setThumbTintColor:", newValue) }
    }
    var minimumTrackTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setMinimumTrackTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setMinimumTrackTintColor:", newValue) }
    }
    var maximumTrackTintColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setMaximumTrackTintColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setMaximumTrackTintColor:", newValue) }
    }
}
extension XTTheme where Base: UIPopoverPresentationController
{
    var backgroundColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBackgroundColor:", newValue) }
    }
}
extension XTTheme where Base: UIRefreshControl
{
    var titleAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "updateTitleAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "updateTitleAttributes:", newValue) }
    }
}
extension XTTheme where Base: UIVisualEffectView
{
    var effect: ThemeVisualEffectPicker? {
        get { return getThemePicker(base, "setEffect:") as? ThemeVisualEffectPicker }
        set { setThemePicker(base, "setEffect:", newValue) }
    }
}
@available(iOS 13.0, *)
extension XTTheme where Base: UINavigationBarAppearance
{
    var titleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "setTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "setTitleTextAttributes:", newValue) }
    }
    var largeTitleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(base, "setLargeTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(base, "setLargeTitleTextAttributes:", newValue) }
    }
    var backIndicatorImage: ThemeImagePicker? {
        get { return getThemePicker(base, "setBackIndicatorImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setBackIndicatorImage:", newValue) }
    }
}
@available(iOS 13.0, *)
extension XTTheme where Base: UIBarAppearance
{
    var backgroundColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setBackgroundColor:", newValue) }
    }
    var backgroundImage: ThemeImagePicker? {
        get { return getThemePicker(base, "setBackgroundImage:") as? ThemeImagePicker }
        set { setThemePicker(base, "setBackgroundImage:", newValue) }
    }
    var backgroundEffect: ThemeBlurEffectPicker? {
        get { return getThemePicker(base, "setBackgroundEffect:") as? ThemeBlurEffectPicker }
        set { setThemePicker(base, "setBackgroundEffect:", newValue) }
    }
    var shadowColor: ThemeColorPicker? {
        get { return getThemePicker(base, "setShadowColor:") as? ThemeColorPicker }
        set { setThemePicker(base, "setShadowColor:", newValue) }
    }
    var shadowImage: ThemeImagePicker? {
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
