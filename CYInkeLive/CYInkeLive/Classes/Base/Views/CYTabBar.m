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
//        [self addSubview:self.cameraButton];
    }
    return self;
}

#pragma mark - override
// 从最下层往上遍历， 如果button在item下，最后找到的是item，响应item
// 响应超出superview的button
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tmpPoint = [self.cameraButton convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.cameraButton.bounds, tmpPoint)) {
            view = self.cameraButton;
        }
    }
    return view;
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
        [self addSubview:_cameraButton];
    }
    return _cameraButton;
}

- (void)cameraButtonClick {
    if (self.cDelegate && [self.cDelegate respondsToSelector:@selector(cameraButtonClick:)]) {
        [self.cDelegate cameraButtonClick:self];
    }
}

@end
