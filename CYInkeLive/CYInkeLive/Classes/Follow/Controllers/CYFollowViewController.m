//
//  CYFollowViewController.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYFollowViewController.h"
#import "CYFollowEmptyView.h"

@interface CYFollowViewController ()

@property (nonatomic, strong) CYFollowEmptyView *emptyView;

@end

@implementation CYFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.emptyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CYFollowEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[CYFollowEmptyView alloc] initWithFrame:self.view.bounds];
    }
    return _emptyView;
}

@end
