//
//  SwitchNightCell.m
//  SwiftTheme
//
//  Created by Gesen on 16/5/27.
//  Copyright © 2016年 Gesen. All rights reserved.
//

#import "SwitchNightCell.h"
#import "Global.h"
#import "MyThemes.h"
#import <SwiftTheme/SwiftTheme-Swift.h>

@implementation SwitchNightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.title.theme.textColor = globalTextColorPicker;
    self.nightIcon.theme.image = [ThemeImagePicker pickerWithNames:@[@"icon_night_dark", @"icon_night_dark", @"icon_night_dark", @"icon_night_light"]];
    
    [self updateNightSwitch];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNightSwitch) name:@"ThemeUpdateNotification" object:nil];
}

- (IBAction)changeNight:(UISwitch *)sender {
    [MyThemes switchNight:sender.on];
}

- (void)updateNightSwitch {
    self.nightSwitch.on = [MyThemes isNight];
}

@end
