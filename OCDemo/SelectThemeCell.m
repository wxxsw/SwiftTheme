//
//  SelectThemeCell.m
//  SwiftTheme
//
//  Created by Gesen on 16/5/27.
//  Copyright © 2016年 Gesen. All rights reserved.
//

#import "SelectThemeCell.h"
#import "Global.h"
#import <SwiftTheme/SwiftTheme-Swift.h>

@implementation SelectThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.title.theme.textColor = globalTextColorPicker;
    self.themeIcon.theme.image = [ThemeImagePicker pickerWithNames:@[@"icon_theme.red", @"icon_theme.yellow", @"icon_theme.blue", @"icon_theme.light"]];
}

@end
