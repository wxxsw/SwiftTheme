//
//  CALayer.swift
//  SwiftTheme
//
//  Created by Phuong Doan Duy on 6/12/24.
//

import UIKit

@objc public extension CALayer {
    var theme_backgroundColor: ThemeCGColorPicker? {
        get { return getThemePicker(self, "setBackgroundColor:") as? ThemeCGColorPicker}
        set { setThemePicker(self, "setBackgroundColor:", newValue) }
    }
    var theme_borderWidth: ThemeCGFloatPicker? {
        get { return getThemePicker(self, "setBorderWidth:") as? ThemeCGFloatPicker }
        set { setThemePicker(self, "setBorderWidth:", newValue) }
    }
    var theme_borderColor: ThemeCGColorPicker? {
        get { return getThemePicker(self, "setBorderColor:") as? ThemeCGColorPicker }
        set { setThemePicker(self, "setBorderColor:", newValue) }
    }
    var theme_shadowColor: ThemeCGColorPicker? {
        get { return getThemePicker(self, "setShadowColor:") as? ThemeCGColorPicker }
        set { setThemePicker(self, "setShadowColor:", newValue) }
    }
    var theme_strokeColor: ThemeCGColorPicker? {
        get { return getThemePicker(self, "setStrokeColor:") as? ThemeCGColorPicker }
        set { setThemePicker(self, "setStrokeColor:", newValue) }
    }
    var theme_fillColor: ThemeCGColorPicker?{
        get { return getThemePicker(self, "setFillColor:") as? ThemeCGColorPicker }
        set { setThemePicker(self, "setFillColor:", newValue) }
    }
}

@objc public extension CATextLayer {
    var theme_foregroundColor: ThemeCGColorPicker? {
        get { return getThemePicker(self, "setForegroundColor:") as? ThemeCGColorPicker}
        set { setThemePicker(self, "setForegroundColor:", newValue) }
    }
}

@objc public extension CAGradientLayer {
    var theme_colors: ThemeAnyPicker? {
        get { return getThemePicker(self, "setColors:") as? ThemeAnyPicker }
        set { setThemePicker(self, "setColors:", newValue) }
    }
}
