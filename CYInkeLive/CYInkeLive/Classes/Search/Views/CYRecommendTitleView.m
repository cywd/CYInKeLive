//
//  CYRecommendTitleView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/17.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYRecommendTitleView.h"

@interface CYRecommendTitleView ()

@end

@implementation CYRecommendTitleView

- (IBAction)recommendClick:(id)sender {
    if (self.recommdMoreClick) {
        self.recommdMoreClick(self.recommedTitle.text);
    }
}

@end
