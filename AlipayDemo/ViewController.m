//
//  ViewController.m
//  AlipayDemo
//
//  Created by 廖超龙 on 2018/8/17.
//  Copyright © 2018年 ZZinKin. All rights reserved.
//

#import "ViewController.h"

#define RANDOM_FLOAT_VALUE ((arc4random()%1001)/1000.0)
#define RANDOM_COLOR [UIColor colorWithRed:RANDOM_FLOAT_VALUE green:RANDOM_FLOAT_VALUE blue:RANDOM_FLOAT_VALUE alpha:1.0]

@interface ViewController () <UIScrollViewDelegate> {
    CGFloat screenWidth;
    CGFloat navigationBarHeight;
    CGFloat navigationNormalHeight;
    CGFloat recommendServiceHeight;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIView *serviceView;
@property (weak, nonatomic) UIView *navigationView;
@property (weak, nonatomic) UIView *customNavigationBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenWidth = CGRectGetWidth(UIScreen.mainScreen.bounds);
    navigationBarHeight = CGRectGetHeight(UIApplication.sharedApplication.statusBarFrame) + 44; //滑到上面去的导航栏
    navigationNormalHeight = navigationBarHeight + 64; //正常状态的导航栏
    recommendServiceHeight = 180; //推荐服务高度（瞎猜的）
    
    UIView *navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, navigationBarHeight)];
    navigationBar.backgroundColor = UIColor.blueColor;
    [self.view addSubview:navigationBar];
    navigationBar.alpha = 0;
    _customNavigationBar = navigationBar;
    
    UIView *navigationView =  [[UIView alloc] initWithFrame:CGRectMake(0, -navigationNormalHeight-recommendServiceHeight, screenWidth, navigationNormalHeight)];
    navigationView.backgroundColor = UIColor.blueColor;
    [_scrollView addSubview:navigationView];
    _navigationView = navigationView;
    
    UIView *serviceView =  [[UIView alloc] initWithFrame:CGRectMake(0, -recommendServiceHeight, screenWidth, recommendServiceHeight)];
    serviceView.backgroundColor = RANDOM_COLOR;
    [_scrollView addSubview:serviceView];
    _serviceView = serviceView;
    
    CGFloat itemPadding = 10;
    CGFloat rowHeight = 80; //其他内容行高
    for (NSInteger i = 0; i < 10; i++) {
        UIView *rowItem = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                   (itemPadding+rowHeight)*i+itemPadding,
                                                                   screenWidth, rowHeight)];
        rowItem.backgroundColor = RANDOM_COLOR;
        [_scrollView addSubview:rowItem];
    }
    _scrollView.contentSize = CGSizeMake(screenWidth, 10*(itemPadding+rowHeight)+itemPadding);
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.scrollView.contentInset = UIEdgeInsetsMake(recommendServiceHeight+navigationNormalHeight, 0, 0, 0);
    [_scrollView setContentOffset:CGPointMake(0, -_scrollView.contentInset.top)];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat deltaY = scrollView.contentOffset.y + navigationNormalHeight + recommendServiceHeight;
    if (deltaY < 0) {
        _navigationView.frame = CGRectMake(0, scrollView.contentOffset.y, screenWidth, navigationNormalHeight);
        _serviceView.frame = CGRectMake(0, scrollView.contentOffset.y+navigationNormalHeight, screenWidth, recommendServiceHeight);
        _customNavigationBar.alpha = 0;
    } else {
        _navigationView.frame = CGRectMake(0, -navigationNormalHeight-recommendServiceHeight, screenWidth, navigationNormalHeight);
        _serviceView.frame = CGRectMake(0, -recommendServiceHeight, screenWidth, recommendServiceHeight);
        _customNavigationBar.alpha = 1;
    }
}


@end
