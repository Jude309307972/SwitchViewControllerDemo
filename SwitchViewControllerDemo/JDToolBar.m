//
//  JDToolBar.m
//  SwitchViewControllerDemo
//
//  Created by XUN on 16/8/25.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "JDToolBar.h"

@interface JDToolBar ()

@property (weak, nonatomic) UIButton *disAbleBtn;//!<


@end

@implementation JDToolBar

+ (instancetype)toolBar
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (IBAction)btnClick:(UIButton *)sender {
    self.disAbleBtn.enabled = YES;
    sender.enabled = NO;
    self.disAbleBtn = sender;
}


@end
