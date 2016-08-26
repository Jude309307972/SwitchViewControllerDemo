//
//  JDVerticalButton.m
//  SwitchViewControllerDemo
//
//  Created by XUN on 16/8/25.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "JDVerticalButton.h"
#import "UIView+JDExtension.h"

@implementation JDVerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x = (self.width - 18) / 2;
    self.imageView.y = 5;
    self.imageView.height = 18;
    self.imageView.width = 18;

    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
