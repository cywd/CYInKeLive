//
//  CYHotTableViewCell.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYHotTableViewCell.h"
#import <Masonry.h>
#import "CYLiveModel.h"
#import <UIImageView+WebCache.h>
#import "CYCreatorModel.h"

@interface CYHotTableViewCell ()

// 头像
@property (nonatomic, strong) UIImageView *iconImageView;

// 名字
@property (nonatomic, strong) UILabel *nameLabel;

// 所在城市
@property (nonatomic, strong) UILabel *cityLabel;

// 在线人数
@property (nonatomic, strong) UILabel *onLineLabel;

// 封面
@property (nonatomic, strong) UIImageView *coverImageView;

// 心情？？
@property (nonatomic, strong) UILabel *moodLabel;

// 直播logo
@property (nonatomic, strong) UIImageView *logoImageView;

@end

@implementation CYHotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createSubViews {
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(5);
        make.height.width.equalTo(@45);
    }];
    _iconImageView.layer.cornerRadius = 45/2;
    _iconImageView.layer.masksToBounds = YES;
    
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.numberOfLines = 1;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.font = [UIFont fontWithName:@"Candara" size:15];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_top);
        make.left.equalTo(_iconImageView.mas_right).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@200);
    }];
    
    
    _cityLabel = [[UILabel alloc]init];
    _cityLabel.textColor = [UIColor grayColor];
    _cityLabel.font = [UIFont fontWithName:@"Candara" size:13];
    [self.contentView addSubview:_cityLabel];
    [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(3);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.equalTo(_nameLabel.mas_height);
        make.width.equalTo(@100);
    }];
    
    _onLineLabel = [[UILabel alloc] init];
    _onLineLabel.textAlignment = NSTextAlignmentRight;
    _onLineLabel.font = [UIFont systemFontOfSize:15];
//    _onLineLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:_onLineLabel];
    [_onLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.equalTo(@100);
        make.height.equalTo(@45);
    }];
    
    _coverImageView = [[UIImageView alloc] init];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_coverImageView];
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_bottom).offset(10);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    _logoImageView = [[UIImageView alloc]init];
    _logoImageView.image = [UIImage imageNamed:@"live_tag_live"];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_coverImageView.mas_right).offset(-10);
        make.top.equalTo(_coverImageView.mas_top).offset(10);
        make.width.mas_equalTo(_logoImageView.mas_height).multipliedBy(1.3);
    }];
    
    _moodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _moodLabel.textAlignment = NSTextAlignmentLeft;
    _moodLabel.font = [UIFont systemFontOfSize:15];
    _moodLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_moodLabel];
    [_moodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.height.equalTo(@45);
    }];
}

- (void)setModel:(CYLiveModel *)model {
    _model = model;
    
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",model.creator.portrait]];
    [self.iconImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"default_head"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    
    if (model.city.length == 0) {
        _cityLabel.text = @"难道在火星?";
    } else {
        _cityLabel.text = model.city;
    }
    
    _nameLabel.text = model.creator.nick;
    NSString *online_usersStr = [NSString stringWithFormat:@"%zd",model.online_users];
    NSString *onLineText = [NSString stringWithFormat:@"%@ 在看", online_usersStr];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:onLineText];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, online_usersStr.length)];
    
    _onLineLabel.attributedText = str;
    _moodLabel.text = model.name;
    [_coverImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"live_empty_bg"]];
}

@end
