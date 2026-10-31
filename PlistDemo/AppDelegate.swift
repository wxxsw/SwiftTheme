//
//  AppDelegate.swift
//  PlistDemo
//
//  Created by Gesen on 16/3/1.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit
import SwiftTheme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // default: Red.plist
        
        ThemeManager.setTheme(plistName: "Red", path: .mainBundle)
        
        // status bar
        
        if #available(iOS 26.0, *) {
            UIApplication.shared.theme_setStatusBarStyle(ThemeStatusBarStylePicker(v: { UIStatusBarStyle.default }), animated: false)
        } else {
            UIApplication.shared.theme_setStatusBarStyle("UIStatusBarStyle", animated: true)
        }
        
        // navigation bar
        
        // Bind to the storyboard's actual bars so theme changes update visible UI.
        guard let tabController = window?.rootViewController as? UITabBarController,
              let navigationController = tabController.viewControllers?.first as? UINavigationController else {
            return true
        }
        let navigationBar = navigationController.navigationBar
        
        navigationBar.theme_tintColor = "Global.barTextColor"
        let titlePicker = ThemeStringAttributesPicker(keyPath: "Global.barTextColor") { value -> [NSAttributedString.Key : AnyObject]? in
            guard let rgba = value as? String else {
                return nil
            }
            
            let color = UIColor(rgba: rgba)
            let shadow = NSShadow(); shadow.shadowOffset = CGSize.zero
            let titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: color,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.shadow: shadow
            ]
            
            return titleTextAttributes
        }
        
        // tab bar
        
        let tabBar = tabController.tabBar

        tabBar.theme_tintColor = "Global.barTextColor"
        
        if #available(iOS 13.0, *) {
            let navigationAppearance = ThemeNavigationBarAppearancePicker(v: {
                let appearance = UINavigationBarAppearance()
                if #available(iOS 26.0, *) {
                    appearance.configureWithDefaultBackground()
                } else {
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = ThemeManager.color(for: "Global.barTintColor")
                }
                var attributes = titlePicker.value() as? [NSAttributedString.Key: Any] ?? [:]
                if #available(iOS 26.0, *) {
                    attributes[.foregroundColor] = UIColor.label
                }
                appearance.titleTextAttributes = attributes
                appearance.largeTitleTextAttributes = attributes
                return appearance
            })
            navigationBar.theme_standardAppearance = navigationAppearance
            navigationBar.theme_compactAppearance = navigationAppearance
            navigationBar.theme_scrollEdgeAppearance = navigationAppearance
            if #available(iOS 15.0, *) {
                navigationBar.theme_compactScrollEdgeAppearance = navigationAppearance
            }

            let tabAppearance = ThemeTabBarAppearancePicker(v: {
                let appearance = UITabBarAppearance()
                if #available(iOS 26.0, *) {
                    appearance.configureWithDefaultBackground()
                    return appearance
                } else {
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = ThemeManager.color(for: "Global.barTintColor")
                }
                if let textColor = ThemeManager.color(for: "Global.barTextColor") {
                    for itemAppearance in [appearance.stackedLayoutAppearance,
                                           appearance.inlineLayoutAppearance,
                                           appearance.compactInlineLayoutAppearance] {
                        itemAppearance.selected.iconColor = textColor
                        itemAppearance.selected.titleTextAttributes = [.foregroundColor: textColor]
                    }
                }
                return appearance
            })
            tabBar.theme_standardAppearance = tabAppearance
            if #available(iOS 15.0, *) {
                tabBar.theme_scrollEdgeAppearance = tabAppearance
            }
            if #available(iOS 26.0, *) {
                // Let system colors adapt to the Liquid Glass background.
                let systemTint = ThemeColorPicker(v: { UIColor.label })
                navigationBar.theme_tintColor = systemTint
                tabBar.theme_tintColor = systemTint
            }
        } else {
            navigationBar.theme_barTintColor = ThemeColorPicker(keyPath: "Global.barTintColor")
            navigationBar.theme_titleTextAttributes = titlePicker
            tabBar.theme_barTintColor = ThemeColorPicker(keyPath: "Global.barTintColor")
        }

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) { }
    
    func applicationDidEnterBackground(_ application: UIApplication) { }
    
    func applicationWillEnterForeground(_ application: UIApplication) { }
    
    func applicationDidBecomeActive(_ application: UIApplication) { }
    
    func applicationWillTerminate(_ application: UIApplication) { }
    

}

