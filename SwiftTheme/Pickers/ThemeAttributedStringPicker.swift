//
//  ThemeAttributedStringPicker.swift
//  SwiftTheme
//
//  Created by Gesen on 2020/8/26.
//  Copyright © 2020 Gesen. All rights reserved.
//

import UIKit

@objc public final class ThemeAttributedStringPicker: ThemePicker {
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> NSAttributedString?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(_ attributedStrings: [NSAttributedString]...) {
        self.init(v: { ThemeManager.element(for: attributedStrings) })
    }
    
    public required convenience init(arrayLiteral elements: NSAttributedString...) {
        self.init(v: { ThemeManager.element(for: elements) })
    }
    
}

@objc public extension ThemeAttributedStringPicker {
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> NSAttributedString?) -> ThemeAttributedStringPicker {
        return ThemeAttributedStringPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithAttributedStrings(_ attributedStrings: [NSAttributedString]) -> ThemeAttributedStringPicker {
        return ThemeAttributedStringPicker(v: { ThemeManager.element(for: attributedStrings) })
    }
    
}

extension ThemeAttributedStringPicker: ExpressibleByArrayLiteral {}

