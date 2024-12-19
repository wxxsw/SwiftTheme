//
//  NSObject+Theme.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/22.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

fileprivate typealias setCGColorValueIMP        = @convention(c) (NSObject, Selector, CGColor) -> Void
fileprivate typealias setCGFloatValueIMP        = @convention(c) (NSObject, Selector, CGFloat) -> Void
fileprivate typealias setValueForStateIMP       = @convention(c) (NSObject, Selector, AnyObject, UIControl.State) -> Void
fileprivate typealias setKeyboardValueIMP       = @convention(c) (NSObject, Selector, UIKeyboardAppearance) -> Void
fileprivate typealias setActivityStyleValueIMP  = @convention(c) (NSObject, Selector, UIActivityIndicatorView.Style) -> Void
fileprivate typealias setScrollStyleValueIMP    = @convention(c) (NSObject, Selector, UIScrollView.IndicatorStyle) -> Void
fileprivate typealias setBarStyleValueIMP       = @convention(c) (NSObject, Selector, UIBarStyle) -> Void
fileprivate typealias setStatusBarStyleValueIMP = @convention(c) (NSObject, Selector, UIStatusBarStyle, Bool) -> Void

private var themePickersKey: UInt8 = 0
private var addPickerNotificationKey: UInt8 = 0

extension NSObject {
    typealias ThemePickers = [String: ThemePicker]

    var themePickers: ThemePickers {
        get {
            if let themePickers = objc_getAssociatedObject(self, &themePickersKey) as? ThemePickers {
                return themePickers
            }
            let initValue = ThemePickers()
            objc_setAssociatedObject(self, &themePickersKey, initValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return initValue
        }
        set {
            objc_setAssociatedObject(self, &themePickersKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if !newValue.isEmpty {
                _setupThemeNotification()
            }
        }
    }

    var hasAddPickerNotification: Bool {
        get {
            return objc_getAssociatedObject(self, &addPickerNotificationKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &addPickerNotificationKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    func performThemePicker(selector: String, picker: ThemePicker?) {
        let sel = Selector(selector)

        guard responds(to: sel)           else { return }
        guard let value = picker?.value() else { return }
        
        if let statePicker = picker as? ThemeStatePicker {
            let setState = unsafeBitCast(method(for: sel), to: setValueForStateIMP.self)
            statePicker.values.forEach {
                guard let value = $1.value() else {
                    print("SwiftTheme WARNING: Missing value for ThemeStatePicker! Selector: \(String(describing: sel))")
                    return
                }
                setState(self, sel, value as AnyObject, UIControl.State(rawValue: $0))
            }
        } else if let statusBarStylePicker = picker as? ThemeStatusBarStylePicker {
            let setStatusBarStyle = unsafeBitCast(method(for: sel), to: setStatusBarStyleValueIMP.self)
            setStatusBarStyle(self, sel, value as! UIStatusBarStyle, statusBarStylePicker.animated)
        } else if picker is ThemeBarStylePicker {
            let setBarStyle = unsafeBitCast(method(for: sel), to: setBarStyleValueIMP.self)
            setBarStyle(self, sel, value as! UIBarStyle)
        } else if picker is ThemeKeyboardAppearancePicker {
            let setKeyboard = unsafeBitCast(method(for: sel), to: setKeyboardValueIMP.self)
            setKeyboard(self, sel, value as! UIKeyboardAppearance)
        } else if picker is ThemeActivityIndicatorViewStylePicker {
            let setActivityStyle = unsafeBitCast(method(for: sel), to: setActivityStyleValueIMP.self)
            setActivityStyle(self, sel, value as! UIActivityIndicatorView.Style)
        } else if picker is ThemeScrollViewIndicatorStylePicker {
            let setIndicatorStyle = unsafeBitCast(method(for: sel), to: setScrollStyleValueIMP.self)
            setIndicatorStyle(self, sel, value as! UIScrollView.IndicatorStyle)
        } else if picker is ThemeCGFloatPicker {
            let setCGFloat = unsafeBitCast(method(for: sel), to: setCGFloatValueIMP.self)
            setCGFloat(self, sel, value as! CGFloat)
        } else if picker is ThemeCGColorPicker {
            let setCGColor = unsafeBitCast(method(for: sel), to: setCGColorValueIMP.self)
            setCGColor(self, sel, value as! CGColor)
        } else {
            perform(sel, with: value)
        }
    }
}

extension NSObject {
    
    fileprivate func _setupThemeNotification() {
        if hasAddPickerNotification == false {
            hasAddPickerNotification = true
            NotificationCenter.default.addObserver(
                forName: NSNotification.Name(rawValue: ThemeUpdateNotification),
                object: nil,
                queue: nil,
                using: { [weak self] notification in
                    self?._updateTheme()
                }
            )
        }
    }
    
    @objc private func _updateTheme() {
        themePickers.forEach { selector, picker in
            UIView.animate(withDuration: ThemeManager.animationDuration) {
                self.performThemePicker(selector: selector, picker: picker)
                // For iOS 13, force an update of the nav bar when the theme changes.
                if #available(iOS 13.0, *) {
                    if let navBar = self as? UINavigationBar {
                        navBar.setNeedsLayout()
                    }
                }
            }
        }
    }
    
}
