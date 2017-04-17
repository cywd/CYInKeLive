//
//  CYRecommendTableViewCell.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/14.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYRecommendTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void (^followBlock)(NSIndexPath *indexPath);

@end
