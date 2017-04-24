//
//  CYAnchorView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/14.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYAnchorView.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "CYLiveModel.h"
#import "CYCreatorModel.h"

@interface CYAnchorView ()

// 头像
@property (nonatomic, strong) UIImageView *iconImageView;

// 直播
@property (nonatomic, strong) UILabel *liveLabel;

// 在线人数
@property (nonatomic, strong) UILabel *lineLabel;

// 关注
@property (nonatomic, strong) UIButton *followButton;

@end

@implementation CYAnchorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.layer.cornerRadius = self.bounds.size.height/2;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.liveLabel];
    [self addSubview:self.lineLabel];
    [self addSubview:self.followButton];
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(2);
        make.width.height.equalTo(@32);
    }];
    
    [self.liveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.iconImageView.mas_top);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@16);
    }];
    
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.top.equalTo(self.liveLabel.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@16);
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        //        make.width.equalTo(@40);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
}

- (void)setModel:(CYLiveModel *)model {
    _model = model;
    
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.creator.portrait]];
    [self.iconImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"default_head"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    self.lineLabel.text = [NSString stringWithFormat:@"%zd",model.online_users];
//    self.liveLabel.text = [NSString stringWithFormat:@"%@", model.creator.nick];
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.layer.cornerRadius = 16;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.textColor = [UIColor whiteColor];
        _lineLabel.textAlignment = NSTextAlignmentLeft;
        _lineLabel.font = [UIFont systemFontOfSize:10];
    }
    return _lineLabel;
}

- (UILabel *)liveLabel {
    if (!_liveLabel) {
        _liveLabel = [[UILabel alloc]init];
        _liveLabel.textColor = [UIColor whiteColor];
        _liveLabel.text = @"直播";
        _liveLabel.textAlignment = NSTextAlignmentLeft;
        _liveLabel.font = [UIFont systemFontOfSize:10];
    }
    return _liveLabel;
}

- (UIButton *)followButton {
    if (!_followButton) {
        _followButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_followButton setBackgroundImage:[UIImage imageNamed:@"live_guanzhu_"] forState:UIControlStateNormal];
        [_followButton setTitle:@"关注" forState:UIControlStateNormal];
        _followButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_followButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _followButton;
}

@end
