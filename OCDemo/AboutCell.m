//
//  AboutCell.m
//  SwiftTheme
//
//  Created by Gesen on 16/5/26.
//  Copyright © 2016年 Gesen. All rights reserved.
//

#import "AboutCell.h"
#import "Global.h"
#import <SwiftTheme/SwiftTheme-Swift.h>

@implementation AboutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.content.theme.textColor = globalTextColorPicker;
}

@end
