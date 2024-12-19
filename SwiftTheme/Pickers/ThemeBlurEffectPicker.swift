//
//  ThemeBlurEffectPicker.swift
//  SwiftTheme
//
//  Created by Kevin on 10/2/19.
//

import UIKit

@objc public final class ThemeBlurEffectPicker: ThemePicker {

    public convenience init(keyPath: String, map: @escaping (Any?) -> UIBlurEffect?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }

    public convenience init(appearances: UIBlurEffect...) {
        self.init(v: { ThemeManager.element(for: appearances) })
    }

    public required convenience init(arrayLiteral elements: UIBlurEffect...) {
        self.init(v: { ThemeManager.element(for: elements) })
    }

}

@objc public extension ThemeBlurEffectPicker {

    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UIBlurEffect?) -> ThemeBlurEffectPicker {
        return ThemeBlurEffectPicker(keyPath: keyPath, map: map)
    }

    class func pickerWithAppearances(_ appearances: [UIBlurEffect]) -> ThemeBlurEffectPicker {
        return ThemeBlurEffectPicker(v: { ThemeManager.element(for: appearances) })
    }

}

extension ThemeBlurEffectPicker: ExpressibleByArrayLiteral {}
