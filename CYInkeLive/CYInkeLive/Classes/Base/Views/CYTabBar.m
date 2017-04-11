//
//  CYTabBar.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/10.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYTabBar.h"
#import "UIView+Frame.h"

@interface CYTabBar ()

@property (strong, nonatomic) UIButton *cameraButton;

@end

@implementation CYTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.cameraButton];
    }
    return self;
}

#pragma mark - override
// 响应超出superview的button
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *v = [super hitTest:point withEvent:event];
    if (v == nil) {
        CGPoint tp = [self.cameraButton convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.cameraButton.bounds, tp)) {
            v = self.cameraButton;
        }
    }
    return v;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.cameraButton.centerY = self.height * 0.125;
    
    CGFloat tabBarItemWidth = self.width / 3;
    self.cameraButton.centerX = self.width * 0.5;
    CGFloat tabBarItemIndex = 0;
    for (UIView *childItem in self.subviews) {
        if ([childItem isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            childItem.width = tabBarItemWidth;
            childItem.x = tabBarItemIndex*tabBarItemWidth;
            tabBarItemIndex ++;
            if (tabBarItemIndex == 1) {
                tabBarItemIndex ++;
            }
        }
    }
}

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(cameraButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _cameraButton.frame = CGRectMake(0, 0, _cameraButton.currentBackgroundImage.size.width, _cameraButton.currentBackgroundImage.size.height);
        self.backgroundColor = [UIColor whiteColor];
    }
    return _cameraButton;
}

- (void)cameraButtonClick {
    if (self.cDelegate && [self.cDelegate respondsToSelector:@selector(cameraButtonClick:)]) {
        [self.cDelegate cameraButtonClick:self];
    }
}

@end
