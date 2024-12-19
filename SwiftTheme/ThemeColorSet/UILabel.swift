//
//  UILabel.swift
//  SwiftTheme
//
//  Created by Phuong Doan Duy on 6/12/24.
//

import UIKit

@objc public extension UILabel {
    var theme_font: ThemeFontPicker? {
        get { return getThemePicker(self, "setFont:") as? ThemeFontPicker }
        set { setThemePicker(self, "setFont:", newValue) }
    }
    var theme_textColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setTextColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setTextColor:", newValue) }
    }
    var theme_highlightedTextColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setHighlightedTextColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setHighlightedTextColor:", newValue) }
    }
    var theme_shadowColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setShadowColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setShadowColor:", newValue) }
    }
    var theme_textAttributes: ThemeStringAttributesPicker? {
        get { return getThemePicker(self, "updateTextAttributes:") as? ThemeStringAttributesPicker }
        set { setThemePicker(self, "updateTextAttributes:", newValue) }
    }
    var theme_attributedText: ThemeAttributedStringPicker? {
        get { return getThemePicker(self, "setAttributedText:") as? ThemeAttributedStringPicker }
        set { setThemePicker(self, "setAttributedText:", newValue) }
    }
}
