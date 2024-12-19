//
//  UIKit+Theme.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/22.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

@objc public extension UITabBarItem {
    var theme_selectedImage: ThemeImagePicker? {
        get { return getThemePicker(self, "setSelectedImage:") as? ThemeImagePicker }
        set { setThemePicker(self, "setSelectedImage:", newValue) }
    }
}

@objc public extension UITableView {
    var theme_separatorColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setSeparatorColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setSeparatorColor:", newValue) }
    }
    var theme_sectionIndexColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setSectionIndexColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setSectionIndexColor:", newValue) }
    }
    var theme_sectionIndexBackgroundColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setSectionIndexBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setSectionIndexBackgroundColor:", newValue) }
    }
}

@objc public extension UITextField {
    var theme_font: ThemeFontPicker? {
        get { return getThemePicker(self, "setFont:") as? ThemeFontPicker }
        set { setThemePicker(self, "setFont:", newValue) }
    }
    var theme_keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { return getThemePicker(self, "setKeyboardAppearance:") as? ThemeKeyboardAppearancePicker }
        set { setThemePicker(self, "setKeyboardAppearance:", newValue) }
    }
    var theme_textColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setTextColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setTextColor:", newValue) }
    }
    var theme_placeholderAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(self, "updatePlaceholderAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(self, "updatePlaceholderAttributes:", newValue) }
    }
}

@objc public extension UITextView {
    var theme_font: ThemeFontPicker? {
        get { return getThemePicker(self, "setFont:") as? ThemeFontPicker }
        set { setThemePicker(self, "setFont:", newValue) }
    }
    var theme_keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { return getThemePicker(self, "setKeyboardAppearance:") as? ThemeKeyboardAppearancePicker }
        set { setThemePicker(self, "setKeyboardAppearance:", newValue) }
    }
    var theme_textColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setTextColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setTextColor:", newValue) }
    }
}

@objc public extension UISearchBar {
    var theme_barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(self, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(self, "setBarStyle:", newValue) }
    }
    var theme_keyboardAppearance: ThemeKeyboardAppearancePicker? {
        get { return getThemePicker(self, "setKeyboardAppearance:") as? ThemeKeyboardAppearancePicker }
        set { setThemePicker(self, "setKeyboardAppearance:", newValue) }
    }
    var theme_barTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setBarTintColor:", newValue) }
    }
}

@objc public extension UIProgressView
{
    var theme_progressTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setProgressTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setProgressTintColor:", newValue) }
    }
    var theme_trackTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setTrackTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setTrackTintColor:", newValue) }
    }
}

@objc public extension UIPageControl
{
    var theme_pageIndicatorTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setPageIndicatorTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setPageIndicatorTintColor:", newValue) }
    }
    var theme_currentPageIndicatorTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setCurrentPageIndicatorTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setCurrentPageIndicatorTintColor:", newValue) }
    }
}
@objc public extension UIImageView
{
    var theme_image: ThemeImagePicker? {
        get { return getThemePicker(self, "setImage:") as? ThemeImagePicker }
        set { setThemePicker(self, "setImage:", newValue) }
    }
}
@objc public extension UIActivityIndicatorView
{
    var theme_color: ThemeColorPicker? {
        get { return getThemePicker(self, "setColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setColor:", newValue) }
    }
    var theme_activityIndicatorViewStyle: ThemeActivityIndicatorViewStylePicker? {
        get { return getThemePicker(self, "setActivityIndicatorViewStyle:") as? ThemeActivityIndicatorViewStylePicker }
        set { setThemePicker(self, "setActivityIndicatorViewStyle:", newValue) }
    }
}
@objc public extension UIScrollView
{
    var theme_indicatorStyle: ThemeScrollViewIndicatorStylePicker? {
        get { return getThemePicker(self, "setIndicatorStyle:") as? ThemeScrollViewIndicatorStylePicker }
        set { setThemePicker(self, "setIndicatorStyle:", newValue) }
    }
}
@objc public extension UIButton
{
    func theme_setImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(self, "setImage:forState:", picker, state)
        setThemePicker(self, "setImage:forState:", statePicker)
    }
    func theme_setBackgroundImage(_ picker: ThemeImagePicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(self, "setBackgroundImage:forState:", picker, state)
        setThemePicker(self, "setBackgroundImage:forState:", statePicker)
    }
    func theme_setTitleColor(_ picker: ThemeColorPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(self, "setTitleColor:forState:", picker, state)
        setThemePicker(self, "setTitleColor:forState:", statePicker)
    }
    func theme_setAttributedTitle(_ picker: ThemeAttributedStringPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(self, "setAttributedTitle:forState:", picker, state)
        setThemePicker(self, "setAttributedTitle:forState:", statePicker)
    }
}

@objc public extension UIToolbar {
    var theme_barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(self, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(self, "setBarStyle:", newValue) }
    }
    var theme_barTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setBarTintColor:", newValue) }
    }
}
@objc public extension UISegmentedControl {
    var theme_selectedSegmentTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setSelectedSegmentTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setSelectedSegmentTintColor:", newValue) }
    }
    func theme_setTitleTextAttributes(_ picker: ThemeStringAttributesPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(self, "setTitleTextAttributes:forState:", picker, state)
        setThemePicker(self, "setTitleTextAttributes:forState:", statePicker)
    }
}
@objc public extension UISwitch {
    var theme_onTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setOnTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setOnTintColor:", newValue) }
    }
    var theme_thumbTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setThumbTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setThumbTintColor:", newValue) }
    }
}

@objc public extension UISlider {
    var theme_thumbTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setThumbTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setThumbTintColor:", newValue) }
    }
    var theme_minimumTrackTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setMinimumTrackTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setMinimumTrackTintColor:", newValue) }
    }
    var theme_maximumTrackTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setMaximumTrackTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setMaximumTrackTintColor:", newValue) }
    }
}
@objc public extension UIPopoverPresentationController
{
    var theme_backgroundColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setBackgroundColor:", newValue) }
    }
}
@objc public extension UIRefreshControl {
    var theme_titleAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(self, "updateTitleAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(self, "updateTitleAttributes:", newValue) }
    }
}

@objc public extension UIVisualEffectView {
    var theme_effect: ThemeVisualEffectPicker? {
        get { return getThemePicker(self, "setEffect:") as? ThemeVisualEffectPicker }
        set { setThemePicker(self, "setEffect:", newValue) }
    }
}

@objc public extension UINavigationBarAppearance {
    var theme_titleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(self, "setTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(self, "setTitleTextAttributes:", newValue) }
    }
    var theme_largeTitleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(self, "setLargeTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(self, "setLargeTitleTextAttributes:", newValue) }
    }
    var theme_backIndicatorImage: ThemeImagePicker? {
        get { return getThemePicker(self, "setBackIndicatorImage:") as? ThemeImagePicker }
        set { setThemePicker(self, "setBackIndicatorImage:", newValue) }
    }
}

@objc public extension UIBarAppearance {
    var theme_backgroundColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setBackgroundColor:", newValue) }
    }
    var theme_backgroundImage: ThemeImagePicker? {
        get { return getThemePicker(self, "setBackgroundImage:") as? ThemeImagePicker }
        set { setThemePicker(self, "setBackgroundImage:", newValue) }
    }
    var theme_backgroundEffect: ThemeBlurEffectPicker? {
        get { return getThemePicker(self, "setBackgroundEffect:") as? ThemeBlurEffectPicker }
        set { setThemePicker(self, "setBackgroundEffect:", newValue) }
    }
    var theme_shadowColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setShadowColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setShadowColor:", newValue) }
    }
    var theme_shadowImage: ThemeImagePicker? {
        get { return getThemePicker(self, "setShadowImage:") as? ThemeImagePicker }
        set { setThemePicker(self, "setShadowImage:", newValue) }
    }
}

internal func getThemePicker(
    _ object : NSObject,
    _ selector : String
) -> ThemePicker? {
    return ThemePicker.getThemePicker(object, selector)
}

internal func setThemePicker(
    _ object : NSObject,
    _ selector : String,
    _ picker : ThemePicker?
) {
    return ThemePicker.setThemePicker(object, selector, picker)
}

internal func makeStatePicker(
    _ object : NSObject,
    _ selector : String,
    _ picker : ThemePicker?,
    _ state : UIControl.State
) -> ThemePicker? {
    return ThemePicker.makeStatePicker(object, selector, picker, state)
}
