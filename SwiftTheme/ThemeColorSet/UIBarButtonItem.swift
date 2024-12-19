//
//  UITabBarItem.swift
//  SwiftTheme
//
//  Created by Phuong Doan Duy on 6/12/24.
//

import UIKit

@objc public extension UIBarButtonItem {
    var theme_tintColor: ThemeColorPicker? {
        get { return getThemePicker(self, "setTintColor:") as? ThemeColorPicker }
        set { setThemePicker(self, "setTintColor:", newValue) }
    }
}
