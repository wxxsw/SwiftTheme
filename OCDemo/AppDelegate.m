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
    
    [[UIApplication sharedApplication] theme.setStatusBarStyle:statusPicker animated:YES];

    // navigation bar
    
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
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
    
    navigationBar.theme.tintColor = globalBarTextColorPicker;
    navigationBar.theme.barTintColor = globalBarTintColorPicker;
    navigationBar.theme.titleTextAttributes = [ThemeStringAttributesPicker pickerWithAttributes:titleAttributes];

    // tab bar
    
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.theme.tintColor = globalBarTextColorPicker;
    tabBar.theme.barTintColor = globalBarTintColorPicker;
    
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
