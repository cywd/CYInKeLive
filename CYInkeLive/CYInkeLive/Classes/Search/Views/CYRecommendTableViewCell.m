//
//  CYRecommendTableViewCell.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/14.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYRecommendTableViewCell.h"

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
    
}

@end
