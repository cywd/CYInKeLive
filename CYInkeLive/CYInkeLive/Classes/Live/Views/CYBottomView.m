//
//  CYBottomView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/14.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYBottomView.h"

@interface CYBottomView ()

// 消息弹幕
@property (nonatomic, strong) UIButton *inforButton;

// 礼物
@property (nonatomic, strong) UIButton *giftButton;

// 分享
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) NSArray *imageArr;


@end

@implementation CYBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    for (NSInteger i = 0; i < self.imageArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:self.imageArr[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        if (i == 0) {
            button.frame = CGRectMake(10, 10, 40, 40);
        } else{
            button.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-180)+(i-1) * 60, 10, 40, 40);
        }
        [self addSubview:button];
    }
}

- (void)bottomClick:(id)sender {
    UIButton *tagButton = (UIButton *)sender;
    if (self.buttonClick) {
        self.buttonClick(tagButton.tag);
    }
}

- (NSArray *)imageArr {
    if (_imageArr == nil) {
        _imageArr = @[@"mg_room_btn_liao_h", @"mg_room_btn_liwu_h", @"mg_room_btn_fenxiang_h"];
    }
    return _imageArr;
}

@end
