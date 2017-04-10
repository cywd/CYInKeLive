//
//  CYTabBarController.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/10.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYTabBarController.h"
#import "CYTabBar.h"
#import "CYBaseNavViewController.h"

#import "CYHomeViewController.h"
#import "CYCameraViewController.h"
#import "CYMeViewController.h"

@interface CYTabBarController () <CYTabBarDelegate>

@end

@implementation CYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backView = [[UIView alloc] initWithFrame:self.view.frame];
    backView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    self.tabBar.tintColor = [UIColor blackColor];
    
    //隐藏tabBar上的线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
    CYTabBar *tabBar = [[CYTabBar alloc] init];
    tabBar.cDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    [self initChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initChildViewControllers {
    //首页
    CYHomeViewController *homePageVC = [[CYHomeViewController alloc] init];
    CYBaseNavViewController *homeNav = [[CYBaseNavViewController alloc] initWithRootViewController:homePageVC];
    [self addChildViewController:homeNav image:@"tab_live" selectedImage:@"tab_live_p"];
    
    //个人
    CYMeViewController *meVC = [[CYMeViewController alloc] init];
    CYBaseNavViewController *meNav = [[CYBaseNavViewController alloc] initWithRootViewController:meVC];
    [self addChildViewController:meNav image:@"tab_me" selectedImage:@"tab_me_p"];
    
}

- (void)addChildViewController:(UIViewController *)nav image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UIViewController *childViewController = nav.childViewControllers.firstObject;
    //tabBarItem图片,显示原图，否则变形
    UIImage *normal = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childViewController.tabBarItem.image = normal;
    childViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

#pragma mark - delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animatedWIthIndex:index];
}

#pragma mark - private
- (void)animatedWIthIndex:(NSInteger)index {
    NSMutableArray *tabArr = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabArr addObject:tabBarButton];
        }
    }
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    base.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    base.duration = 0.1;
    base.repeatCount = 1;
    base.autoreverses = YES;
    base.fromValue = [NSNumber numberWithFloat:0.8];
    base.toValue = [NSNumber numberWithFloat:1.2];
    [[tabArr[index] layer] addAnimation:base forKey:@"Base"];
}

@end
