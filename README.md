## SwitchViewControllerDemo
一种简便实现多个控制器滑动切换的方式 ，只需继承SJSwitchViewController，再实现SJSwitchViewControllerDelegate的2个方法就搞定，比起scrollview的实现方式省事

![image](https://github.com/Jude309307972/SwitchViewControllerDemo/blob/master/switch.gif)

## Usage 使用方法
#####1. 下载demo,将子文件夹SJSwitch拖入项目中，创建新控制器继承SJSwitchViewController作为容器控制器


```#import <UIKit/UIKit.h>
#import "SJSwitchViewController.h"

@interface ViewController : SJSwitchViewController


@end
```
#####2. 添加所需自控制到数组

```
 ChildViewController *childVC = [[ChildViewController alloc] init];
        childVC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255) alpha:1];
        childVC.indicatorStr =  [NSString stringWithFormat:@"第%ld栏目",(long)i];
        [self.viewControllers addObject:childVC];

```

#####3. 实现SJSwitchViewControllerDelegate方法
```- (NSInteger)numberOfSwitchViewController
{
    return self.viewControllers.count;
}

- (UIViewController *)switchViewControllerDidGetViewControllerAtIndex:(NSUInteger)index
{
    return [self.viewControllers objectAtIndex:index];
}
```
#####4. 跟切换控制的按钮交互
``` // 点击滚动到对应的控制器
    [self setShowingIndex:button.tag animate:YES];
 // 告诉外界滑动到对应的控制器下标index
-(void)switchViewControllerDidStopAtIndex:(NSInteger)index
{
    UIButton *button = self.titlesView.subviews[index];
    [self buttonStateChange:button];
}
```
######5.SJSwitchViewControllerDelegate其他方法，大家可自行尝试，比如rectOfView 根据需求调整自控制的view在父控制的位置

```/**
 *	@brief	加载在View上的视图尺寸
 *
 *	@return
 */
-(CGRect)rectOfView;
```

![image](https://github.com/Jude309307972/SwitchViewControllerDemo/blob/master/xiaoya.gif)


