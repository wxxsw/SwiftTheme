//
//  ListViewController.m
//  SwiftTheme
//
//  Created by Gesen on 16/5/26.
//  Copyright © 2016年 Gesen. All rights reserved.
//

#import "ListViewController.h"
#import "Global.h"
#import <SwiftTheme/SwiftTheme-Swift.h>

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.theme.backgroundColor = globalBackgroundColorPicker;
    self.tableView.theme.separatorColor = [ThemeColorPicker pickerWithColors:@[@"#C6C5C5", @"#C6C5C5", @"#C6C5C5", @"#ECF0F1"]];
}

@end
