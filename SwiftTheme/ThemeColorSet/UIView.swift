//
//  UIView.swift
//  SwiftTheme
//
//  Created by Phuong Doan Duy on 6/12/24.
//

import UIKit

@objc public extension UIView {
    var theme_alpha: ThemeCGFloatPicker? {
        get { return getThemePicker(self, "setAlpha:") as? ThemeCGFloatPicker }
        set { setThemePicker(self, "setAlpha:", newValue) }
    }
    var theme_backgroundColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setBackgroundColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setBackgroundColor:", newValue) }
    }
    var theme_tintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setTintColor:", newValue) }
    }
}
