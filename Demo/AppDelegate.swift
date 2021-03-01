//
//  AppDelegate.swift
//  Demo
//
//  Created by Gesen on 16/1/23.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit
import SwiftTheme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application:UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        MyThemes.restoreLastTheme()
        
        // status bar
        
        UIApplication.shared.theme.setStatusBarStyle([.lightContent, .default, .lightContent, .lightContent], animated: true)
        
        // navigation bar

        let navigationBar = UINavigationBar.appearance()
        
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 0)
        
        let titleAttributes = GlobalPicker.barTextColors.map { hexString in
            return [
                NSAttributedString.Key.foregroundColor: UIColor(rgba: hexString),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                NSAttributedString.Key.shadow: shadow
            ]
        }
        
        navigationBar.theme.tintColor = GlobalPicker.barTextColor
        navigationBar.theme.barTintColor = GlobalPicker.barTintColor
        navigationBar.theme.titleTextAttributes = ThemeStringAttributesPicker.pickerWithAttributes(titleAttributes)
        
        // tab bar
        
        let tabBar = UITabBar.appearance()
        
        tabBar.theme.tintColor = GlobalPicker.barTextColor
        tabBar.theme.barTintColor = GlobalPicker.barTintColor
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) {
        MyThemes.saveLastTheme()
    }


}

