//
//  File.swift
//  
//
//  Created by Hooi Ling on 13/12/22.
//


import UIKit

#if os(iOS)
extension UITabBarItem {

    /// Sets vertical value for titlePositionAdjustment.
    ///
    /// Triggered by SwiftTheme when `theme_titlePositionAdjustmentVertical` is used.
    @objc func setTitlePositionAdjustmentVertical(_ value: CGFloat) {
        titlePositionAdjustment = UIOffset(horizontal: 0, vertical: value)
    }

    /// Sets negative vertical value for titlePositionAdjustment.
    ///
    /// Triggered by SwiftTheme when `theme_titlePositionAdjustmentVerticalNegative` is used.
    @objc func setTitlePositionAdjustmentVerticalNegative(_ value: CGFloat) {
        titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -value)
    }
}
#endif
