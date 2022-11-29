//
//  File.swift
//  
//
//  Created by Ryan Tan on 29/11/22.
//

import Foundation

import UIKit

#if os(iOS)
extension NSLayoutConstraint {

    /// Sets constant for the constraint.
    ///
    /// Triggered by SwiftTheme when theme_constraintConstant is used.
    @objc func setConstraintConstant(_ value: CGFloat) {
        constant = value
    }
}
#endif
