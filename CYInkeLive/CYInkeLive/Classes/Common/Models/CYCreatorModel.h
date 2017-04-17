//
//  CYCreatorModel.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/11.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYCreatorModel : NSObject

/** 主播名 */
@property (nonatomic, strong) NSString *nick;
/** 主播头像 */
@property (nonatomic, strong) NSString *portrait;

@property (nonatomic, copy) NSString *third_platform;

@property (nonatomic, assign) NSInteger rank_veri;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, assign) NSInteger gmutex;

@property (nonatomic, assign) NSInteger verified;

@property (nonatomic, copy) NSString *emotion;

@property (nonatomic, assign) NSInteger inke_verify;

@property (nonatomic, copy) NSString *verified_reason;

@property (nonatomic, copy) NSString *birth;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *hometown;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *veri_info;

@property (nonatomic, assign) NSInteger gender;

@property (nonatomic, copy) NSString *profession;

@end
