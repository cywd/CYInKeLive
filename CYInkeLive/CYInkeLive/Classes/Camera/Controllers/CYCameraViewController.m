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
#import "UIView+Frame.h"

@interface CYCameraViewController ()

@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation CYCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startLiveStream];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /*
    //由小变大的圆形动画
    CGFloat radius = [UIScreen mainScreen].bounds.size.height;
    UIBezierPath *startMask =  [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.centerX, self.view.centerY, 0, 0)];
    UIBezierPath *endMask = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(self.view.centerX, self.view.centerY, 0, 0), -radius, -radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endMask.CGPath;
    maskLayer.backgroundColor = (__bridge CGColorRef)([UIColor whiteColor]);
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startMask.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endMask.CGPath));
    maskLayerAnimation.duration = 0.8f;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    self.view.layer.mask = maskLayer;
     
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//开始直播采集
- (void)startLiveStream {
    CYStartLiveView *view = [[CYStartLiveView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
}

@end
