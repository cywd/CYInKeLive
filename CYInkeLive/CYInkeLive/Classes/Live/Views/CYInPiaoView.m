//
//  CYInPiaoView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/24.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYInPiaoView.h"
#import <Masonry.h>

@interface CYInPiaoView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation CYInPiaoView

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

    
    [self addSubview:self.label];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"映票：282818218";
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont systemFontOfSize:10];
    }
    return _label;
}

@end
