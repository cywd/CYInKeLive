//
//  CYCameraViewController.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/10.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYCameraViewController.h"
#import "CYStartLiveView.h"
#import <Masonry.h>

@interface CYCameraViewController ()

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation CYCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self startLiveStream];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//开始直播采集
- (void)startLiveStream {
    
    CYStartLiveView *view = [[CYStartLiveView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

@end
