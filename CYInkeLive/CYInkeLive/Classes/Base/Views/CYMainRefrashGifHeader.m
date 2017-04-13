//
//  CYMainRefrashGifHeader.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/13.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYMainRefrashGifHeader.h"

@implementation CYMainRefrashGifHeader

- (void)prepare {
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=29; i++) {
        
        NSString *str = [NSString stringWithFormat:@"refresh_fly_00%zd",i];
        UIImage *orignImage = [UIImage imageNamed:str];
        UIImage *image = [self scaleToSize:orignImage size:CGSizeMake(60, 52)];
        [idleImages addObject:image];
    }
    
    [self setImages:idleImages duration:0.5f forState:MJRefreshStateIdle];
    [self setImages:idleImages duration:0.5f forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages duration:0.5f forState:MJRefreshStateRefreshing];
}

//压缩图片
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

@end
