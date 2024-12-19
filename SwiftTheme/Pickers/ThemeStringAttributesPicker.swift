//
//  ThemeStringAttributesPicker.swift
//  SwiftTheme
//
//  Created by Gesen on 2019/9/1.
//  Copyright © 2019 Gesen. All rights reserved.
//

import UIKit

@objc public final class ThemeStringAttributesPicker: ThemePicker {
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> [NSAttributedString.Key: Any]?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(_ attributes: [NSAttributedString.Key: Any]...) {
        self.init(v: { ThemeManager.element(for: attributes) })
    }
    
    public required convenience init(arrayLiteral elements: [NSAttributedString.Key: Any]...) {
        self.init(v: { ThemeManager.element(for: elements) })
    }
    
}

@objc public extension ThemeStringAttributesPicker {
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> [NSAttributedString.Key: Any]?) -> ThemeStringAttributesPicker {
        return ThemeStringAttributesPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithAttributes(_ attributes: [[NSAttributedString.Key: Any]]) -> ThemeStringAttributesPicker {
        return ThemeStringAttributesPicker(v: { ThemeManager.element(for: attributes) })
    }
    
}

extension ThemeStringAttributesPicker: ExpressibleByArrayLiteral {}

