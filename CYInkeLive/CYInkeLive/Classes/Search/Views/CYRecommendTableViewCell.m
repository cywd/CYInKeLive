//
//  CYRecommendTableViewCell.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/14.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYRecommendTableViewCell.h"
#import "CYRecommendModel.h"
#import "CYLiveModel.h"
#import "CYCreatorModel.h"
#import <UIImageView+WebCache.h>

@interface CYRecommendTableViewCell ()

// 头像
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

// 昵称、等级
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTextLabel;

// 关注
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation CYRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)followClick:(id)sender {
    if (self.followBlock) {
        self.followBlock(self.indexPath);
    }
}

- (void)setModel:(Users *)model {
    _model = model;
    
    User *userModel = model.user;
    NSString *relation = model.relation;
    
    NSString *str = userModel.portrait;
    if ([str rangeOfString:@"http://img2.inke.cn/"].location == NSNotFound) {
        str = [NSString stringWithFormat:@"http://img2.inke.cn/%@",str];
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_head"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
    self.nickNameLabel.text = userModel.nick;
    self.subTextLabel.text = userModel.hometown;
    
    if (relation.length > 4) {
        [self.addButton setImage:[UIImage imageNamed:@"button_choose-on"] forState:UIControlStateNormal];
    } else {
        [self.addButton setImage:[UIImage imageNamed:@"icon_+"] forState:UIControlStateNormal];
    }
}

@end
