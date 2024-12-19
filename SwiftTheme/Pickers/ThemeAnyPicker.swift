//
//  ThemeAnyPicker.swift
//  SwiftTheme
//
//  Created by Gesen on 2020/8/26.
//  Copyright © 2020 Gesen. All rights reserved.
//

import UIKit

@objc public final class ThemeAnyPicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { ThemeManager.value(for: keyPath) })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> Any?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(anys: Any...) {
        self.init(v: { ThemeManager.element(for: anys) })
    }
    
    public required convenience init(arrayLiteral elements: Any...) {
        self.init(v: { ThemeManager.element(for: elements) })
    }
    
}

@objc public extension ThemeAnyPicker {
    
    class func pickerWithKeyPath(_ keyPath: String) -> ThemeAnyPicker {
        return ThemeAnyPicker(keyPath: keyPath)
    }
    
    class func pickerWithAnys(_ fonts: [Any]) -> ThemeAnyPicker {
        return ThemeAnyPicker(v: { ThemeManager.element(for: fonts) })
    }
    
}

extension ThemeAnyPicker: ExpressibleByArrayLiteral {}

