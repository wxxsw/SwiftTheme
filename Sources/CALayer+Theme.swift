//
//  CALayer+Theme.swift
//  
//
//  Created by Hooi Ling on 14/12/22.
//

import Foundation
import QuartzCore

extension CALayer {
    /// Sets corner radius on CALayer
    ///
    /// Triggered by SwiftTheme when theme_cornerRadius is used.
    /// - Parameter value: a `ThemeCGFloatPicker` value
    ///
    /// Not called setCornerRadius so as not to conflict with existing func with same name.
    @objc func customSetCornerRadius(_ value: CGFloat) {
        cornerRadius = value
    }
}
