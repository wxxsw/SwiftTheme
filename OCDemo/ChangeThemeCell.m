//
//  ChangeThemeCell.m
//  SwiftTheme
//
//  Created by Gesen on 16/5/27.
//  Copyright © 2016年 Gesen. All rights reserved.
//

#import "ChangeThemeCell.h"
#import "MyThemes.h"
#import <SwiftTheme/SwiftTheme-Swift.h>

@implementation ChangeThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.changeTheme theme.setTitleColor:[ThemeColorPicker pickerWithColors:@[@"#FFF", @"#000", @"#FFF", @"#000"]] forState:UIControlStateNormal];
    [self.changeTheme theme.setTitleColor:[ThemeColorPicker pickerWithColors:@[@"#555", @"#AAA", @"#555", @"#AAA"]] forState:UIControlStateHighlighted];
    self.changeTheme.theme.backgroundColor = [ThemeColorPicker pickerWithColors:@[@"#EB4F38", @"#F4C600", @"#56ABE4", @"#ECF0F1"]];
    self.changeTheme.layer.cornerRadius = self.changeTheme.bounds.size.width / 2;
}

- (IBAction)tapChange:(UIButton *)sender {
    [MyThemes switchToNext];
}

@end
