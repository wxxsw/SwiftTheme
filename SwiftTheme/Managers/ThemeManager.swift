//
//  ThemeManager.swift
//  SwiftTheme
//
//  Created by Gesen on 16/1/22.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import Foundation

public let ThemeUpdateNotification = "ThemeUpdateNotification"

@objc public final class ThemeManager: NSObject {
    
    public static var animationDuration = 0.3
    
    public fileprivate(set) static var currentTheme: NSDictionary?
    public fileprivate(set) static var currentThemeIndex: Int = 0
}

@objc public extension ThemeManager {

    class func setTheme(index: Int) {
        currentThemeIndex = index
    }

    internal class func update() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: ThemeUpdateNotification), object: nil)
    }

    class func updateThemeData(dict: NSDictionary) {
        currentTheme = dict
        update()
    }
}
