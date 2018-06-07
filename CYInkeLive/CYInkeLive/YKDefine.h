//
//  YKDefine.h
//  CYInkeLive
//
//  Created by cyrill on 2018/6/7.
//  Copyright © 2018年 Cyrill. All rights reserved.
//

#ifndef YKDefine_h
#define YKDefine_h

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// iPhone X
#define  IS_IPHONEX (SCREEN_MIN_LENGTH == 375.f && SCREEN_MAX_LENGTH == 812.f ? YES : NO)

#define  CY_STATUS_H  ([UIApplication sharedApplication].statusBarFrame.size.height)
#define  CY_TABBAR_H  (IS_IPHONEX ? (49.f+34.f) : 49.f)
#define  CY_NAVBAR_H  (IS_IPHONEX ? 88.f : 64.f)
#define  CY_NAVBAR_H_NoStatus  44.f

#define  CY_TabbarSafeBottomMargin  (IS_IPHONEX ? 34.f : 0.f)

#define CY_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#endif /* YKDefine_h */
