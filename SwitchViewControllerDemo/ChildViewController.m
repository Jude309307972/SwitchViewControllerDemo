//
//  ChildViewController.m
//  SwitchViewControllerDemo
//
//  Created by Jude on 16/8/30.
//  Copyright © 2016年 Jude. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()
@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)setIndicatorStr:(NSString *)indicatorStr
{
    _indicatorStr = indicatorStr;
     self.indicatorLabel.text = self.indicatorStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
