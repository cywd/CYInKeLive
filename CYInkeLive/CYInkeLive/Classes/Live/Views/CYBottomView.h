//
//  CYBottomView.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/14.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYBottomView : UIView

@property (nonatomic, copy) void (^buttonClick)(NSInteger tag);

@end
