//
//  CYBaseViewController.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/10.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYBaseNavViewController.h"

@interface CYBaseNavViewController ()

@end

@implementation CYBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *barAppearance = [UINavigationBar appearance];
    barAppearance.backgroundColor = [UIColor colorWithRed:62/255.0 green:173/255.0 blue:176/255.0 alpha:1.0];
    [barAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
