//
//  ViewController.m
//  SwitchViewControllerDemo
//
//  Created by XUN on 16/8/25.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "ViewController.h"
#import "JDToolBar.h"
#import "UIView+JDExtension.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    JDToolBar *toolBar = [JDToolBar toolBar];
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
