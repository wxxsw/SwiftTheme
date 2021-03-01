//
//  BaseCell.m
//  SwiftTheme
//
//  Created by Gesen on 16/5/26.
//  Copyright © 2016年 Gesen. All rights reserved.
//

#import "BaseCell.h"
#import "Global.h"
#import <SwiftTheme/SwiftTheme-Swift.h>

@implementation BaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.theme.backgroundColor = globalBackgroundColorPicker;
}

@end
