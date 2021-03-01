//
//  AppDelegate.swift
//  JsonDemo
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
        
        // default: Red.json
        
        ThemeManager.setTheme(jsonName: "Red", path: .mainBundle)
        
        // status bar
        
        UIApplication.shared.theme.setStatusBarStyle("UIStatusBarStyle", animated: true)
        
        // navigation bar
        
        let navigationBar = UINavigationBar.appearance()
        
        navigationBar.theme.tintColor = "Global.barTextColor"
        navigationBar.theme.barTintColor = "Global.barTintColor"
        navigationBar.theme.titleTextAttributes = ThemeStringAttributesPicker(keyPath: "Global.barTextColor") { value -> [NSAttributedString.Key : AnyObject]? in
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
        
        let tabBar = UITabBar.appearance()

        tabBar.theme.tintColor = "Global.barTextColor"
        tabBar.theme.barTintColor = "Global.barTintColor"
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) { }
    
    func applicationDidEnterBackground(_ application: UIApplication) { }
    
    func applicationWillEnterForeground(_ application: UIApplication) { }
    
    func applicationDidBecomeActive(_ application: UIApplication) { }
    
    func applicationWillTerminate(_ application: UIApplication) { }
    

}

