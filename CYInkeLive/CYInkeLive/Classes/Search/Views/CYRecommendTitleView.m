//
//  CYRecommendTitleView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/17.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYRecommendTitleView.h"

@interface CYRecommendTitleView ()

// 好声音、小清新、搞笑达人
@property (weak, nonatomic) IBOutlet UILabel *recommedTitle;

// 更多
@property (weak, nonatomic) IBOutlet UIButton *recommendButton;

@end

@implementation CYRecommendTitleView

- (IBAction)recommendClick:(id)sender {
    if (self.recommdMoreClick) {
        self.recommdMoreClick(self.recommedTitle.text);
    }
}

@end
