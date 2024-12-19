//
//  UITabBar.swift
//  SwiftTheme
//
//  Created by Phuong Doan Duy on 6/12/24.
//

import UIKit

@objc public extension UITabBar {
    var theme_barStyle: ThemeBarStylePicker? {
        get { return getThemePicker(self, "setBarStyle:") as? ThemeBarStylePicker }
        set { setThemePicker(self, "setBarStyle:", newValue) }
    }

    var theme_unselectedItemTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setUnselectedItemTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setUnselectedItemTintColor:", newValue) }
    }
    var theme_barTintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setBarTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setBarTintColor:", newValue) }
    }
    var theme_standardAppearance: ThemeTabBarAppearancePicker? {
        get { return getThemePicker(self, "setStandardAppearance:") as? ThemeTabBarAppearancePicker }
        set { setThemePicker(self, "setStandardAppearance:", newValue) }
    }
    var theme_compactAppearance: ThemeTabBarAppearancePicker? {
        get { return getThemePicker(self, "setCompactAppearance:") as? ThemeTabBarAppearancePicker }
        set { setThemePicker(self, "setCompactAppearance:", newValue) }
    }
    var theme_scrollEdgeAppearance: ThemeTabBarAppearancePicker? {
        get { return getThemePicker(self, "setScrollEdgeAppearance:") as? ThemeTabBarAppearancePicker }
        set { setThemePicker(self, "setScrollEdgeAppearance:", newValue) }
    }
}
