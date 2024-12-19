//
//  UIBarItem.swift
//  SwiftTheme
//
//  Created by Phuong Doan Duy on 6/12/24.
//

import UIKit

@objc public extension UIBarItem {
    var theme_image: ThemeImagePicker? {
        get { return getThemePicker(self, "setImage:") as? ThemeImagePicker }
        set { setThemePicker(self, "setImage:", newValue) }
    }
    func theme_setTitleTextAttributes(_ picker: ThemeStringAttributesPicker?, forState state: UIControl.State) {
        let statePicker = makeStatePicker(self, "setTitleTextAttributes:forState:", picker, state)
        setThemePicker(self, "setTitleTextAttributes:forState:", statePicker)
    }
}
