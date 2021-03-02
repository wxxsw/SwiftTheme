//
//  SelectThemeViewController.m
//  SwiftTheme
//
//  Created by Gesen on 16/5/27.
//  Copyright © 2016年 Gesen. All rights reserved.
//

#import "SelectThemeViewController.h"
#import "Global.h"
#import "MyThemes.h"
#import <SwiftTheme/SwiftTheme-Swift.h>

@interface SelectThemeViewController ()

@end

@implementation SelectThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.theme.backgroundColor = globalBackgroundColorPicker;
}

- (IBAction)tapRed:(id)sender {
    [MyThemes switchTo:MyThemesTypeRed];
}

- (IBAction)tapYellow:(id)sender {
    [MyThemes switchTo:MyThemesTypeYellow];
}

- (IBAction)tapBlue:(id)sender {
    [MyThemes switchTo:MyThemesTypeBlue];
}

@end
