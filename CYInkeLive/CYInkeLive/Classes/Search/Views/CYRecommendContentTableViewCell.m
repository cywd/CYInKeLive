//
//  CYRecommendContentTableViewCell.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/17.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYRecommendContentTableViewCell.h"

@interface CYRecommendContentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewF;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewS;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewT;
@property (weak, nonatomic) IBOutlet UILabel *LabelF;
@property (weak, nonatomic) IBOutlet UILabel *LabelS;
@property (weak, nonatomic) IBOutlet UILabel *LabelT;

@end

@implementation CYRecommendContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //添加长按缩小、离开还原的动画
    self.imageViewF.userInteractionEnabled = YES;
    self.imageViewS.userInteractionEnabled = YES;
    self.imageViewT.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *pressF = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    pressF.minimumPressDuration = 0.3;
    [self.imageViewF addGestureRecognizer:pressF];
    UIView *singleTapView = [pressF view];
    singleTapView.tag = self.imageViewF.tag;
    
    UILongPressGestureRecognizer *pressS = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    pressS.minimumPressDuration = 0.3;
    [self.imageViewS addGestureRecognizer:pressS];
    UIView *singleTapViewS = [pressS view];
    singleTapViewS.tag = self.imageViewS.tag;
    
    UILongPressGestureRecognizer *pressT = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
    pressT.minimumPressDuration = 0.3;
    [self.imageViewT addGestureRecognizer:pressT];
    UIView *singleTapViewT = [pressT view];
    singleTapViewT.tag = self.imageViewT.tag;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

// 长按
- (void)longPressClick:(UILongPressGestureRecognizer *)sender{
    NSInteger tag = [sender view].tag;
    if (sender.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.5 animations:^{
            switch (tag) {
                case 50:
                    self.imageViewF.transform = CGAffineTransformMakeScale(0.8, 0.8);
                    break;
                case 51:
                    self.imageViewS.transform = CGAffineTransformMakeScale(0.8, 0.8);
                    break;
                case 52:
                    self.imageViewT.transform = CGAffineTransformMakeScale(0.8, 0.8);
                    break;
                default:
                    break;
            }
        }];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageViewF.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.imageViewS.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.imageViewT.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
    
}

@end
