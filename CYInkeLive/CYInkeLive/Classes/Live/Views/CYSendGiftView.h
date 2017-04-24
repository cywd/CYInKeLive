//
//  CYSendGiftView.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/24.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYSendGiftView : UIView

@property (nonatomic, copy) void (^giftClick)(NSInteger tag);

@property (nonatomic, copy) void (^grayClick)();

- (void)popShow;

@end
