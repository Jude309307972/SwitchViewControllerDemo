//
//  ViewController.m
//  SwitchViewControllerDemo
//
//  Created by XUN on 16/8/25.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "ViewController.h"
#import "ChildViewController.h"
#import "UIView+JDExtension.h"

@interface ViewController ()
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewController];
    // 设置顶部的标签栏
    [self setupTitlesView];
}

- (void)setupChildViewController
{
    for (int i = 0; i < 5; i++) {
        ChildViewController *childVC = [[ChildViewController alloc] init];
        childVC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255) alpha:1];
        childVC.indicatorStr =  [NSString stringWithFormat:@"第%ld栏目",(long)i];
        [self.viewControllers addObject:childVC];
    }
}

/**
 * 设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    CGFloat width = titlesView.width / self.viewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.viewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        NSString *title = [NSString stringWithFormat:@"第%ld栏目",(long)i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}

- (void)titleClick:(UIButton *)button
{
    [self buttonStateChange:button];
    // 滚动
    [self setShowingIndex:button.tag animate:YES];
}

- (void)buttonStateChange:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];

}

#pragma mark -SJSwitchViewControllerDelegate

- (NSInteger)numberOfSwitchViewController
{
    return self.viewControllers.count;
}

- (UIViewController *)switchViewControllerDidGetViewControllerAtIndex:(NSUInteger)index
{
    return [self.viewControllers objectAtIndex:index];
}

-(void)switchViewControllerDidStopAtIndex:(NSInteger)index
{
    UIButton *button = self.titlesView.subviews[index];
    [self buttonStateChange:button];
}


@end
