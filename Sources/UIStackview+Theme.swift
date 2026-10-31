//
//  UIStackview+Theme.swift
//
//  Setters used by ThemePickers operating on UIStackView.
//
//  Created by Ryan Tan on 29/11/22.
//

import UIKit

#if os(iOS)
extension UIStackView {

    /// Sets spacing on stack views..
    ///
    /// Triggered by SwiftTheme when theme_stackViewSpacing is used.
    @objc func setStackViewSpacing(_ value: CGFloat) {
        spacing = value
    }

    /// Sets padding left on stack views.
    ///
    /// Triggered by SwiftTheme when theme_paddingLeft is used.
    /// - Parameter value: a `ThemeCGFloatPicker` value
    @objc func setStackViewPaddingLeft(_ value: CGFloat) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = value
    }

    /// Sets padding top on stack views.
    ///
    /// Triggered by SwiftTheme when theme_paddingTop is used.
    /// - Parameter value: a `ThemeCGFloatPicker` value
    @objc func setStackViewPaddingTop(_ value: CGFloat) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = value
    }

    /// Sets padding right on stack views.
    ///
    /// Triggered by SwiftTheme when theme_paddingRight is used.
    /// - Parameter value: a `ThemeCGFloatPicker` value
    @objc func setStackViewPaddingRight(_ value: CGFloat) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.right = value
    }

    /// Sets padding bottom on stack views.
    ///
    /// Triggered by SwiftTheme when theme_paddingBottom is used.
    /// - Parameter value: a `ThemeCGFloatPicker` value
    @objc func setStackViewPaddingBottom(_ value: CGFloat) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.bottom = value
    }

    /// Sets padding for vertical (top, bottom) on stack views.
    ///
    /// Triggered by SwiftTheme when theme_paddingVertical is used.
    /// - Parameter value: a `ThemeCGFloatPicker` value
    @objc func setStackViewPaddingVertical(_ value: CGFloat) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.top = value
        layoutMargins.bottom = value
    }

    /// Sets padding for horizontal (leading, trailing) on stack views.
    ///
    /// Triggered by SwiftTheme when theme_paddingHorizontal is used.
    /// - Parameter value: a `ThemeCGFloatPicker` value
    @objc func setStackViewPaddingHorizontal(_ value: CGFloat) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins.left = value
        layoutMargins.right = value
    }

    /// Sets padding all sides on stack views.
    ///
    /// Triggered by SwiftTheme when theme_padding is used.
    /// - Parameter value: a `ThemeCGFloatPicker` value
    @objc func setStackViewPadding(_ value: CGFloat) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}
#endif
