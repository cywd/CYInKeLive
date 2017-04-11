//
//  CYFollowEmptyView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYFollowEmptyView.h"
#import <Masonry.h>

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define BackGroundColor RGBA(239, 239, 239, 1.0f)
#define EmptyMargin ([UIScreen mainScreen].bounds.size.width - 200)/2


@interface CYFollowEmptyView ()

//空视图
@property (nonatomic,strong) UIImageView *emptyImageView;

//提示跳转按钮
@property (nonatomic,strong) UIButton *skipButton;

@end

@implementation CYFollowEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = BackGroundColor;
        [self addSubview:self.emptyImageView];
        [self addSubview:self.skipButton];
        [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(EmptyMargin);
            make.right.equalTo(self).offset(-EmptyMargin);
            make.height.width.offset(200);
        }];
        
        [self.skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.emptyImageView.mas_bottom).offset(10);
            make.left.right.width.equalTo(self.emptyImageView);
            make.height.equalTo(@20);
        }];
    }
    return self;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipButton setTitle:@"去看看最新精彩直播" forState:UIControlStateNormal];
        [_skipButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _skipButton;
}


- (UIImageView *)emptyImageView {
    if (!_emptyImageView) {
        _emptyImageView = [[UIImageView alloc]init];
        _emptyImageView.image = [UIImage imageNamed:@"default_person_empty"];
    }
    return _emptyImageView;
}


@end
