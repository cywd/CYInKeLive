//
//  UIView+CYDisplay.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/14.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CYDisplay)

/** 判断View是否显示在屏幕上 */
- (BOOL)isDisplayedInScreen;

/** 判断self和anotherView是否重叠 */
- (BOOL)cy_intersectsWithAnotherView:(UIView *)anotherView;

@end
