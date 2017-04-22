//
//  CYTabBar.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/10.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYTabBar.h"
#import "UIView+Frame.h"
#import "YKConst.h"

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
// Application -> Window -> RootView -> SubView
// 响应超出superview的button
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isHidden == NO) {
        
        CGPoint newP = [self convertPoint:point toView:self.cameraButton];
        
        // 增加圆角判断
        CGFloat radius = CGRectGetWidth(self.cameraButton.frame) / 2;
        CGPoint offset = CGPointMake(newP.x - radius, newP.y - radius);
        
        if ([self.cameraButton pointInside:newP withEvent:event]) {
            if (sqrt(offset.x * offset.x + offset.y * offset.y) <= radius) {
                return self.cameraButton;
            } else {
                return nil;
            }
        } else {
            return [super hitTest:point withEvent:event];
        }
    } else {
        return [super hitTest:point withEvent:event];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    static BOOL added = NO;
    
    self.cameraButton.centerY = self.height * 0.125;
    
    CGFloat tabBarItemWidth = self.width / 3;
    self.cameraButton.centerX = self.width * 0.5;
    CGFloat tabBarItemIndex = 0;
    for (UIControl *control in self.subviews) {
        
        if (![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class]]) continue;
        control.width = tabBarItemWidth;
        control.x = tabBarItemWidth * tabBarItemIndex;
        tabBarItemIndex ++;
        if (tabBarItemIndex == 1) {
            tabBarItemIndex++;
        }
        
        if (added == NO) {
            // 监听按钮点击
            [control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)controlClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:CYTabBarDidSelectNotification object:nil userInfo:nil];
}

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setBackgroundImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(cameraButtonClick) forControlEvents:UIControlEventTouchUpInside];
        CGFloat imgWidth = _cameraButton.currentBackgroundImage.size.width;
        _cameraButton.frame = CGRectMake(0, 0, imgWidth, imgWidth);
        _cameraButton.layer.cornerRadius = imgWidth/2.0;
        _cameraButton.layer.masksToBounds = YES;
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
