//
//  CYGiftCollectionViewCell.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/24.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYGiftCollectionViewCell.h"
#import <Masonry.h>

@interface CYGiftCollectionViewCell ()

@end

@implementation CYGiftCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self).offset(25);
    }];
    
    [self.hitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.height.width.equalTo(@25);
    }];
}

- (void)createUI {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self addSubview:self.giftImageView];
    [self addSubview:self.hitButton];
}

- (UIImageView *)giftImageView{
    if (!_giftImageView) {
        _giftImageView = [[UIImageView alloc]init];
        _giftImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _giftImageView;
}

- (UIButton *)hitButton{
    if (!_hitButton) {
        _hitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hitButton setImage:[UIImage imageNamed:@"pop_gift_lian"] forState:UIControlStateNormal];
        [_hitButton setImage:[UIImage imageNamed:@"button_choose-on"] forState:UIControlStateSelected];
    }
    return _hitButton;
}

@end
