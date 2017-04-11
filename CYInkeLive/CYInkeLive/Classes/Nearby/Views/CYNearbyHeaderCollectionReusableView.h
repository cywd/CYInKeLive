//
//  CYNearbyHeaderCollectionReusableView.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYNearbyHeaderCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy) void (^chooseCondition)();

- (void)setBtnTitle:(NSString *)title;

@end
