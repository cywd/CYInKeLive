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

//头像
@property (nonatomic,strong)UIImageView *iconImageView;

//直播
@property (nonatomic,strong)UILabel *liveLabel;

//在线人数
@property (nonatomic,strong)UILabel *lineLabel;

@end

@implementation CYAnchorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    self.layer.cornerRadius = 15;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.liveLabel];
    [self addSubview:self.lineLabel];
    
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
}

- (void)setModel:(CYLiveModel *)model {
    _model = model;
    
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.creator.portrait]];
    [self.iconImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"default_head"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    self.lineLabel.text = [NSString stringWithFormat:@"%zd人在线",model.online_users];
    self.liveLabel.text = [NSString stringWithFormat:@"%@", model.creator.nick];
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
        _lineLabel.font = [UIFont systemFontOfSize:8];
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

@end
