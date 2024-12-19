//
//  ThemeTabBarAppearancePicker.swift
//  
//
//  Created by Ruslan Popesku on 15.10.2021.
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
@objc public final class ThemeTabBarAppearancePicker: ThemePicker {

    public convenience init(keyPath: String, map: @escaping (Any?) -> UITabBarAppearance?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }

    public convenience init(appearances: UITabBarAppearance...) {
        self.init(v: { ThemeManager.element(for: appearances) })
    }

    public required convenience init(arrayLiteral elements: UITabBarAppearance...) {
        self.init(v: { ThemeManager.element(for: elements) })
    }

}

@available(iOS 13.0, tvOS 13.0, *)
@objc public extension ThemeTabBarAppearancePicker {

    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UITabBarAppearance?) -> ThemeTabBarAppearancePicker {
        ThemeTabBarAppearancePicker(keyPath: keyPath, map: map)
    }

    class func pickerWithAppearances(_ appearances: [UITabBarAppearance]) -> ThemeTabBarAppearancePicker {
        ThemeTabBarAppearancePicker(v: { ThemeManager.element(for: appearances) })
    }

}

@available(iOS 13.0, tvOS 13.0, *)
extension ThemeTabBarAppearancePicker: ExpressibleByArrayLiteral {}

