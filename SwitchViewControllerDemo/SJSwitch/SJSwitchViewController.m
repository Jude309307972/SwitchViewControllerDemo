//
//  SJSwitchViewController.m
//  testChildVC
//
//  Created by 陈少杰 on 14/12/19.
//  Copyright (c) 2014年 陈少杰. All rights reserved.
//

#import "SJSwitchViewController.h"
#import "SJSwitchCell.h"
//      屏幕宽高
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface SJSwitchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic)UICollectionView *switchBackgroundView;
@end

@implementation SJSwitchViewController
-(id)init{
    self=[super init];
    if (self) {

    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

-(void)awakeFromNib{
    
   
}

#pragma mark 预加载
-(NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers=[[NSMutableArray alloc]init];
    }
    return _viewControllers;
}

-(UIViewController *)switchViewControllerDidGetViewControllerAtIndex:(NSUInteger)index{
    return nil;
}

-(NSInteger)numberOfSwitchViewController{
    return 0;
}

-(UICollectionView *)switchBackgroundView{
    if (!_switchBackgroundView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [flowLayout setMinimumLineSpacing:0];
        [flowLayout setMinimumInteritemSpacing:0];
        _switchBackgroundView = [[UICollectionView alloc]initWithFrame:[self rectOfView] collectionViewLayout:flowLayout];
        
        // 加载cell视图
        [_switchBackgroundView registerClass:[SJSwitchCell class] forCellWithReuseIdentifier:@"cell"];
        
        _switchBackgroundView.backgroundColor=[UIColor whiteColor];
        _switchBackgroundView.delegate = self;
        _switchBackgroundView.dataSource = self;
        _switchBackgroundView.pagingEnabled=YES;
        _switchBackgroundView.showsVerticalScrollIndicator=NO;
        _switchBackgroundView.showsHorizontalScrollIndicator=NO;
        [self.view addSubview:_switchBackgroundView];
    }
    return _switchBackgroundView;
}

#pragma mark 加载在View上的视图
-(UIView *)viewWithSwithViewController:(id)viewController{
    UIViewController *v=viewController;
    return v.view;
}


#pragma mark 加载在View上的视图尺寸
-(CGRect)rectOfView{
    return CGRectMake(0,0,[UIScreen  mainScreen].bounds.size.width, [UIScreen  mainScreen].bounds.size.height);
}


#pragma mark 停止拽动得时候调用。
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.x<0) {
        if ([self respondsToSelector:@selector(switchViewControllerDidDragLeft)]) {
            [self switchViewControllerDidDragLeft];
        }
    }
    
    if (scrollView.contentOffset.x+scrollView.bounds.size.width>scrollView.contentSize.width) {
        if ([self respondsToSelector:@selector(switchViewControllerDidDragRight)]) {
            [self switchViewControllerDidDragRight];
        }
    }
    
    if (!decelerate) {
        [self switchViewControllerDidStop];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        [self switchViewControllerDidscoll:scrollView.contentOffset];
    }
}

- (void)switchViewControllerDidscoll:(CGPoint)point
{
  
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self switchViewControllerDidStop];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self switchViewControllerDidStop];
}

-(void)switchViewControllerDidStop{
    [self switchViewControllerDidStopAtIndex:self.showingIndex];
}

-(void)switchViewControllerDidStopAtIndex:(NSInteger)index{

}

-(NSInteger)showingIndex{
    NSIndexPath *indexPath=[self.switchBackgroundView indexPathForItemAtPoint:CGPointMake(self.switchBackgroundView.contentOffset.x+kScreenWidth/2, self.switchBackgroundView.contentOffset.y+kScreenHeight/2)];
    return indexPath.row;
}

-(void)setShowingIndex:(NSInteger)showingIndex animate:(BOOL)animate{
    [self.switchBackgroundView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:showingIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:animate];
    [self switchViewControllerDidStop];
}

-(void)setShowingIndex:(NSInteger)showingIndex{
    [self setShowingIndex:showingIndex animate:NO];
}

//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self numberOfSwitchViewController];
}

//设置元素内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    
    SJSwitchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
   // [cell sizeToFit];

    if (!cell) {
        //cell=[[VideoCell alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        
    }
    for (UIView *v in [cell.contentView subviews]) {
        [v removeFromSuperview];
    }
    [cell.thisViewController removeFromParentViewController];
    
    UIViewController *subVC=[self switchViewControllerDidGetViewControllerAtIndex:indexPath.row];
    cell.thisViewController=subVC;
    [self addChildViewController:subVC];
    
    UIView *v=[self viewWithSwithViewController:subVC];
    v.frame = cell.bounds;
    [cell.contentView addSubview:v ];
    return cell;
}

//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets top = {0,0,0,0};
    return top;
}

//设置顶部的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={0,0};
    return size;
}


//设置底部的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size={0,0};
    return size;
}



//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size=[self rectOfView].size;
    return size;
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.switchBackgroundView];
    [self.switchBackgroundView reloadData];
    
}


@end
