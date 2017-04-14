//
//  CYSearchViewController.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYSearchViewController.h"
#import "CYSearchView.h"

@interface CYSearchViewController ()

@property (nonatomic, strong) CYSearchView *searchView;

@end

@implementation CYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.searchView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//搜索栏
- (CYSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[CYSearchView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
        __weak typeof(self) weakSelf = self;
        [_searchView setCancleBlock:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _searchView;
}


@end
