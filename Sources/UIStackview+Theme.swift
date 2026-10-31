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
}
#endif
