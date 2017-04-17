//
//  CYLiveModel.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYCreatorModel;

@interface CYLiveModel : NSObject

/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 主播 */
@property (nonatomic, strong) CYCreatorModel *creator;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, assign) NSInteger room_id;

@property (nonatomic, assign) NSInteger version;

@property (nonatomic, assign) NSInteger rotate;

@property (nonatomic, assign) NSInteger multi;

@property (nonatomic, assign) NSInteger link;

@property (nonatomic, copy) NSString *share_addr;

@property (nonatomic, assign) NSInteger slot;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, assign) NSInteger group;

@property (nonatomic, assign) NSInteger pub_stat;

@property (nonatomic, assign) NSInteger optimal;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger status;


@end
