//
//  CYTopTitleView.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYTopTitleView.h"
#import "UIView+Frame.h"

#define bWidth self.bounds.size.width/self.titleArray.count

@interface CYTopTitleView ()

@property (nonatomic, strong) NSMutableArray *btnArr;

@end

@implementation CYTopTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        for (NSInteger i = 0; i < self.titleArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i * bWidth, 0, bWidth, 44);
            [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [self.btnArr addObject:button];
            
            if (i == 1) {
                [button.titleLabel sizeToFit];
                self.lineImageView.frame = CGRectMake(bWidth, 40, button.titleLabel.width, 3);
                self.lineImageView.centerX = button.centerX;
                [self addSubview:self.lineImageView];
            }
        }
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender {
    NSInteger index = [self.btnArr indexOfObject:sender];
    [self scrollMove:index];
    if (self.titleClick) self.titleClick(index);
}

- (void)scrollMove:(NSInteger)tag {
    UIButton *button = self.btnArr[tag];
    [UIView animateWithDuration:0.3 animations:^{
        self.lineImageView.centerX = button.centerX;
    }];
}

- (NSMutableArray *)btnArr
{
    if (!_btnArr) {
        _btnArr = [[NSMutableArray alloc] init];
    }
    return _btnArr;
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"关注", @"热门", @"附近"];
    }
    return _titleArray;
}

- (UIImageView *)lineImageView{
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = [UIColor yellowColor];
    }
    return _lineImageView;
}

@end
