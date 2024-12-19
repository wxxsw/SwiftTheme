//
//  ThemeDictionaryPicker.swift
//  SwiftTheme
//
//  Created by Gesen on 2017/1/28.
//  Copyright © 2017年 Gesen. All rights reserved.
//

import Foundation

@objc public final class ThemeDictionaryPicker: ThemePicker {
    
    public convenience init<T>(keyPath: String, map: @escaping (Any?) -> [T: AnyObject]?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init<T>(dicts: [T: AnyObject]...) {
        self.init(v: { ThemeManager.element(for: dicts) })
    }
    
    public required convenience init(arrayLiteral elements: [String: AnyObject]...) {
        self.init(v: { ThemeManager.element(for: elements) })
    }
    
}

@objc public extension ThemeDictionaryPicker {
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> [String: AnyObject]?) -> ThemeDictionaryPicker {
        return ThemeDictionaryPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithDicts(_ dicts: [[String: AnyObject]]) -> ThemeDictionaryPicker {
        return ThemeDictionaryPicker(v: { ThemeManager.element(for: dicts) })
    }
    
}

extension ThemeDictionaryPicker: ExpressibleByArrayLiteral {}
