//
//  CYNearbyCollectionViewCell.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYNearbyCollectionViewCell.h"
#import <Masonry.h>
#import "CYLiveModel.h"
#import "CYCreatorModel.h"
#import <UIImageView+WebCache.h>

@interface CYNearbyCollectionViewCell ()

//头像
@property (nonatomic,strong)UIImageView *iconImageView;

//等级
@property (nonatomic,strong)UIImageView *rankImageView;

//距离
@property (nonatomic,strong)UILabel *distanceLabel;

@property (nonatomic,strong)NSMutableArray *arr;

@end

@implementation CYNearbyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    [self addSubview:self.iconImageView];
    [self addSubview:self.distanceLabel];
    [self addSubview:self.rankImageView];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-25);
    }];
    
    [self.rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(4);
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-4);
        make.width.equalTo(@36);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankImageView.mas_right).offset(5);
        make.bottom.right.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom);
    }];
}

- (void)setModel:(CYLiveModel *)model {
    _model = model;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *rankArr = [data allKeys];
    
    int index = arc4random()%rankArr.count;
    
    NSString *rankUrl = rankArr[index];
    
    //随机取一个等级吧
    [self.rankImageView sd_setImageWithURL:[NSURL URLWithString:rankUrl] placeholderImage:[UIImage imageNamed:@"leavel_empty"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.creator.portrait] placeholderImage:[UIImage imageNamed:@"live_empty_bg"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    if (model.distance.length > 0) {
        self.distanceLabel.text = [NSString stringWithFormat:@"%@",model.distance];
    } else {
        //距离远的只显示城市
        if (model.city.length > 0) {
            self.distanceLabel.text = [NSString stringWithFormat:@"%@",model.city];
        } else {
            //没有显示火星
            self.distanceLabel.text = [NSString stringWithFormat:@"火星"];
        }
    }
}

- (void)showAnimation {
    self.iconImageView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    [UIView animateWithDuration:0.25 animations:^{
        self.iconImageView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)distanceLabel {
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc] init];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        _distanceLabel.textColor = [UIColor grayColor];
        _distanceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _distanceLabel;
}

- (UIImageView *)rankImageView {
    if (!_rankImageView) {
        _rankImageView = [[UIImageView alloc] init];
    }
    return _rankImageView;
}

@end
