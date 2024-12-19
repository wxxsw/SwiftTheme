//
//  ThemeColorPicker.swift
//  SwiftTheme
//
//  Created by Gesen on 2017/1/28.
//  Copyright © 2017年 Gesen. All rights reserved.
//

import UIKit

@objc public final class ThemeColorPicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { ThemeManager.color(for: keyPath) })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> UIColor?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(colors: String...) {
        self.init(v: { ThemeManager.colorElement(for: colors) })
    }
    
    public convenience init(colors: UIColor...) {
        self.init(v: { ThemeManager.element(for: colors) })
    }
    
    public required convenience init(arrayLiteral elements: String...) {
        self.init(v: { ThemeManager.colorElement(for: elements) })
    }
    
    public required convenience init(stringLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(unicodeScalarLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(keyPath: value)
    }
    
}

@objc public extension ThemeColorPicker {
    
    class func pickerWithKeyPath(_ keyPath: String) -> ThemeColorPicker {
        return ThemeColorPicker(keyPath: keyPath)
    }
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UIColor?) -> ThemeColorPicker {
        return ThemeColorPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithColors(_ colors: [String]) -> ThemeColorPicker {
        return ThemeColorPicker(v: { ThemeManager.colorElement(for: colors) })
    }
    
    class func pickerWithUIColors(_ colors: [UIColor]) -> ThemeColorPicker {
        return ThemeColorPicker(v: { ThemeManager.element(for: colors) })
    }
    
}

extension ThemeColorPicker: ExpressibleByArrayLiteral {}
extension ThemeColorPicker: ExpressibleByStringLiteral {}
