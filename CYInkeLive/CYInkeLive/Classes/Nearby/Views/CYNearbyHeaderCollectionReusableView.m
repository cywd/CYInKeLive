//
//  CYNearbyHeaderCollectionReusableView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYNearbyHeaderCollectionReusableView.h"

@interface CYNearbyHeaderCollectionReusableView ()

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

@end

@implementation CYNearbyHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//选择查看全部、选择女生、男生
- (IBAction)chooseClick:(id)sender {
    if (self.chooseCondition) {
        self.chooseCondition();
    }
}

- (void)setBtnTitle:(NSString *)title {
    [self.chooseBtn setTitle:title forState:UIControlStateNormal];
}

@end
