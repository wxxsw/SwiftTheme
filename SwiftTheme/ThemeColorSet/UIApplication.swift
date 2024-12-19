//
//  UIApplication.swift
//  SwiftTheme
//
//  Created by Phuong Doan Duy on 6/12/24.
//

import UIKit

@objc public extension UIApplication {
    func theme_setStatusBarStyle(_ picker: ThemeStatusBarStylePicker, animated: Bool) {
        picker.animated = animated
        setThemePicker(self, "setStatusBarStyle:animated:", picker)
    }
}
