//
//  CYTopTitleView.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYTopTitleView : UIView

@property (nonatomic, copy) void (^titleClick)(NSInteger tag);

@property (nonatomic,strong) UIScrollView *titleScrollView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic,strong) UIImageView *lineImageView;

- (void)scrollMove:(NSInteger)tag;

@end
