//
//  SJSwitchViewController.h
//  testChildVC
//
//  Created by 陈少杰 on 14/12/19.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SJSwitchViewControllerDelegate<NSObject>

/**
 *	@brief	某个序列号的VC
 *
 *	@param 	index 	序列号
 *
 *	@return
 */
-(UIViewController*)switchViewControllerDidGetViewControllerAtIndex:(NSUInteger)index;

/**
 *	@brief	总数
 *
 *	@return
 */
-(NSInteger)numberOfSwitchViewController;

@optional
/**
 *	@brief	加载在View上的视图
 *
 *	@param 	viewController 	哪个VC
 *
 *	@return
 */
-(UIView*)viewWithSwithViewController:(id)viewController;

/**
 *	@brief	加载在View上的视图尺寸
 *
 *	@return
 */
-(CGRect)rectOfView;

/**
 *	@brief	滑到最右端
 *
 *	@return
 */
-(void)switchViewControllerDidDragRight;

/**
 *	@brief	滑到最左端
 *
 *	@return	
 */
-(void)switchViewControllerDidDragLeft;

-(void)switchViewControllerDidStopAtIndex:(NSInteger)index;

/**
 *  监听view的滑动
 */
- (void)switchViewControllerDidscoll:(CGPoint)point;

@end

@interface SJSwitchViewController : UIViewController<SJSwitchViewControllerDelegate>
@property(nonatomic)NSMutableArray *viewControllers;
@property(nonatomic)NSInteger showingIndex;
-(void)setShowingIndex:(NSInteger)showingIndex animate:(BOOL)animate;
@end

