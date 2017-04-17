//
//  CYRecommendTitleView.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/17.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYRecommendTitleView : UIView

@property (nonatomic, copy) void (^recommdMoreClick)(NSString *str);

@end
