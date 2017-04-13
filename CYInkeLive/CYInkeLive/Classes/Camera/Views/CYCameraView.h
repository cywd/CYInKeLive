//
//  CYCameraView.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/13.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYCameraView : UIView

@property (nonatomic, copy) void (^buttonClick)(NSInteger tag);

- (void)popShow;

@end
