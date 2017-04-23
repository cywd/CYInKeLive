//
//  CYNetworkManager.m
//  CYInkeLive
//
//  Created by Cyrill on 2017/4/22.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

#import "CYNetworkManager.h"
#import <AFNetworking.h>
#import "YKAPI.h"

@interface CYNetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation CYNetworkManager

+ (instancetype)defaultManager {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (NSURLSessionDataTask *)hotListWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [self.manager GET:INKeUrl parameters:nil progress:nil success:success failure:failure];
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

@end
