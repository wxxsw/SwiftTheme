//
//  AppDelegate.m
//  OCDemo
//
//  Created by Gesen on 16/5/26.
//  Copyright © 2016年 Gesen. All rights reserved.
//

#import "AppDelegate.h"
#import "MyThemes.h"
#import "Global.h"
#import <SwiftTheme/SwiftTheme-Swift.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MyThemes restoreLastTheme];
    
    // status bar
    
    ThemeStatusBarStylePicker *statusPicker = [ThemeStatusBarStylePicker pickerWithStringStyles:globalStatusBarStringStyles];
    if (@available(iOS 26.0, *)) {
        statusPicker = [ThemeStatusBarStylePicker pickerWithStringStyles:@[@"Default", @"Default", @"Default", @"Default"]];
    }
    
    [[UIApplication sharedApplication] theme_setStatusBarStyle:statusPicker animated:YES];

    // navigation bar
    
    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
    if (![tabController isKindOfClass:UITabBarController.class]) { return YES; }
    UINavigationController *navigationController = (UINavigationController *)tabController.viewControllers.firstObject;
    if (![navigationController isKindOfClass:UINavigationController.class]) { return YES; }
    UINavigationBar *navigationBar = navigationController.navigationBar;
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    
    NSMutableArray *titleAttributes = [NSMutableArray array];
    
    for (NSString *rgba in globalBarTextColors) {
        UIColor *color = [[UIColor alloc] initWithRgba_throws:rgba error:nil];
        NSDictionary *attr = @{
            NSForegroundColorAttributeName: color,
            NSFontAttributeName: [UIFont systemFontOfSize:16],
            NSShadowAttributeName: shadow
        };
        [titleAttributes addObject:attr];
    }
    
    navigationBar.theme_tintColor = globalBarTextColorPicker;
    ThemeStringAttributesPicker *titlePicker = [ThemeStringAttributesPicker pickerWithAttributes:titleAttributes];

    // tab bar
    
    UITabBar *tabBar = tabController.tabBar;
    tabBar.theme_tintColor = globalBarTextColorPicker;
    if (@available(iOS 13.0, *)) {
        NSMutableArray *navigationAppearances = [NSMutableArray array];
        NSMutableArray *tabAppearances = [NSMutableArray array];
        for (NSUInteger index = 0; index < globalBarTintColors.count; index++) {
            UIColor *background = [[UIColor alloc] initWithRgba:globalBarTintColors[index] defaultColor:UIColor.clearColor];
            UIColor *foreground = [[UIColor alloc] initWithRgba:globalBarTextColors[index] defaultColor:UIColor.clearColor];
            UINavigationBarAppearance *navigation = [UINavigationBarAppearance new];
            UITabBarAppearance *tab = [UITabBarAppearance new];
            NSMutableDictionary *attributes = [titleAttributes[index] mutableCopy];
            if (@available(iOS 26.0, *)) {
                [navigation configureWithDefaultBackground];
                [tab configureWithDefaultBackground];
                attributes[NSForegroundColorAttributeName] = UIColor.labelColor;
            } else {
                [navigation configureWithOpaqueBackground];
                [tab configureWithOpaqueBackground];
                navigation.backgroundColor = background;
                tab.backgroundColor = background;
                for (UITabBarItemAppearance *item in @[tab.stackedLayoutAppearance,
                                                      tab.inlineLayoutAppearance,
                                                      tab.compactInlineLayoutAppearance]) {
                    item.selected.iconColor = foreground;
                    item.selected.titleTextAttributes = @{NSForegroundColorAttributeName: foreground};
                }
            }
            navigation.titleTextAttributes = attributes;
            navigation.largeTitleTextAttributes = attributes;
            [navigationAppearances addObject:navigation];
            [tabAppearances addObject:tab];
        }
        ThemeNavigationBarAppearancePicker *navigationAppearance = [ThemeNavigationBarAppearancePicker pickerWithAppearances:navigationAppearances];
        navigationBar.theme_standardAppearance = navigationAppearance;
        navigationBar.theme_compactAppearance = navigationAppearance;
        navigationBar.theme_scrollEdgeAppearance = navigationAppearance;
        if (@available(iOS 15.0, *)) {
            navigationBar.theme_compactScrollEdgeAppearance = navigationAppearance;
        }

        ThemeTabBarAppearancePicker *tabAppearance = [ThemeTabBarAppearancePicker pickerWithAppearances:tabAppearances];
        tabBar.theme_standardAppearance = tabAppearance;
        if (@available(iOS 15.0, *)) {
            tabBar.theme_scrollEdgeAppearance = tabAppearance;
        }
        if (@available(iOS 26.0, *)) {
            ThemeColorPicker *systemTint = [ThemeColorPicker pickerWithUIColors:@[UIColor.labelColor, UIColor.labelColor, UIColor.labelColor, UIColor.labelColor]];
            navigationBar.theme_tintColor = systemTint;
            tabBar.theme_tintColor = systemTint;
        }
    } else {
        navigationBar.theme_barTintColor = globalBarTintColorPicker;
        navigationBar.theme_titleTextAttributes = titlePicker;
        tabBar.theme_barTintColor = globalBarTintColorPicker;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application { }

- (void)applicationDidEnterBackground:(UIApplication *)application { }

- (void)applicationWillEnterForeground:(UIApplication *)application { }

- (void)applicationDidBecomeActive:(UIApplication *)application { }

- (void)applicationWillTerminate:(UIApplication *)application {
    [MyThemes saveLastTheme];
}

@end
