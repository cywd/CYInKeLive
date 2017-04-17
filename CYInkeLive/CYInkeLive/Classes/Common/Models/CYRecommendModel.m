//
//  CYRecommendModel.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/17.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYRecommendModel.h"
#import "CYLiveModel.h"

@implementation CYRecommendModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"user_nodes" : [User_Nodes class], @"live_nodes" : [Live_Nodes class]};
}

@end
@implementation User_Nodes

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"users" : [Users class]};
}

@end


@implementation Users

@end


@implementation User

@end


@implementation Live_Nodes

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"lives" : [CYLiveModel class]};
}

@end


