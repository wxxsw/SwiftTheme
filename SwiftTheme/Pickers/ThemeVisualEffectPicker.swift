//
//  ThemeVisualEffectPicker.swift
//  SwiftTheme
//
//  Created by Gesen on 2019/9/1.
//  Copyright © 2019 Gesen. All rights reserved.
//

import UIKit

#if os(iOS)
@objc public final class ThemeVisualEffectPicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { ThemeVisualEffectPicker.getEffect(stringEffect: ThemeManager.string(for: keyPath) ?? "") })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> UIVisualEffect?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(effects: UIVisualEffect...) {
        self.init(v: { ThemeManager.element(for: effects) })
    }
    
    public required convenience init(arrayLiteral elements: UIVisualEffect...) {
        self.init(v: { ThemeManager.element(for: elements) })
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
    
    class func getEffect(stringEffect: String) -> UIVisualEffect {
        switch stringEffect.replacingOccurrences(of: "_", with: "").lowercased() {
        case "dark":
            return UIBlurEffect(style: .dark)
        case "extralight":
            return UIBlurEffect(style: .extraLight)
        case "prominent":
            if #available(iOS 10.0, *) {
                return UIBlurEffect(style: .prominent)
            } else {
                return UIBlurEffect(style: .light)
            }
        case "regular":
            if #available(iOS 10.0, *) {
                return UIBlurEffect(style: .regular)
            } else {
                return UIBlurEffect(style: .light)
            }
        default:
            return UIBlurEffect(style: .light)
        }
    }
    
}

public extension ThemeVisualEffectPicker {
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UIVisualEffect?) -> ThemeVisualEffectPicker {
        return ThemeVisualEffectPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithEffects(_ styles: [UIVisualEffect]) -> ThemeVisualEffectPicker {
        return ThemeVisualEffectPicker(v: { ThemeManager.element(for: styles) })
    }
    
}

@objc public extension ThemeVisualEffectPicker {
    
    class func pickerWithKeyPath(_ keyPath: String) -> ThemeVisualEffectPicker {
        return ThemeVisualEffectPicker(keyPath: keyPath)
    }
    
    class func pickerWithStringEffects(_ effects: [String]) -> ThemeVisualEffectPicker {
        return ThemeVisualEffectPicker(v: { ThemeManager.element(for: effects.map(getEffect)) })
    }
    
}

extension ThemeVisualEffectPicker: ExpressibleByArrayLiteral {}
extension ThemeVisualEffectPicker: ExpressibleByStringLiteral {}
#endif
