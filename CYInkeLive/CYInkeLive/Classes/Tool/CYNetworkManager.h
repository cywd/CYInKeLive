//
//  CYNetworkManager.h
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/22.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYNetworkManager : NSObject

/** 初始化管理者 */
+ (instancetype)defaultManager;

- (nullable NSURLSessionDataTask *)hotListWithParameters:(nullable id)parameters success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
