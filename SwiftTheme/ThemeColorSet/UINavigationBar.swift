//
//  UINavigationBar.swift
//  SwiftTheme
//
//  Created by Phuong Doan Duy on 6/12/24.
//

import UIKit

@objc public extension UINavigationBar {
    var theme_barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(self, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(self, "setBarStyle:", newValue) }
    }
    var theme_barTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setBarTintColor:", newValue) }
    }
    var theme_titleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(self, "setTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(self, "setTitleTextAttributes:", newValue) }
    }
    var theme_largeTitleTextAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(self, "setLargeTitleTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(self, "setLargeTitleTextAttributes:", newValue) }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var theme_standardAppearance: ThemeNavigationBarAppearancePicker? {
        get { return getThemePicker(self, "setStandardAppearance:") as? ThemeNavigationBarAppearancePicker }
        set { setThemePicker(self, "setStandardAppearance:", newValue) }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var theme_compactAppearance: ThemeNavigationBarAppearancePicker? {
        get { return getThemePicker(self, "setCompactAppearance:") as? ThemeNavigationBarAppearancePicker }
        set { setThemePicker(self, "setCompactAppearance:", newValue) }
    }
    @available(iOS 13.0, tvOS 13.0, *)
    var theme_scrollEdgeAppearance: ThemeNavigationBarAppearancePicker? {
        get { return getThemePicker(self, "setScrollEdgeAppearance:") as? ThemeNavigationBarAppearancePicker }
        set { setThemePicker(self, "setScrollEdgeAppearance:", newValue) }
    }
}
