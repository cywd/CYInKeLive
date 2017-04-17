//
//  CYRecommendTableViewCell.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/14.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Users;

@interface CYRecommendTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^followBlock)(NSIndexPath *indexPath);

@property (nonatomic, strong) Users *model;

@end
