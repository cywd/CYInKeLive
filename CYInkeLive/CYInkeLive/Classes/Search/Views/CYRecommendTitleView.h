//
//  CYRecommendTitleView.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/17.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYRecommendTitleView : UIView

// 好声音、小清新、搞笑达人
@property (weak, nonatomic) IBOutlet UILabel *recommedTitle;
// 更多
@property (weak, nonatomic) IBOutlet UIButton *recommendButton;

@property (nonatomic, copy) void (^recommdMoreClick)(NSString *str);

@end
