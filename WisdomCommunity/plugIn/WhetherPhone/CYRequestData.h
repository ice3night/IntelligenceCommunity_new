//
//  CYRequestData.h
//  WisdomCommunity
//
//  Created by bridge on 17/4/15.
//  Copyright © 2017年 bridge. All rights reserved.
//  数据请求

#import <Foundation/Foundation.h>

@interface CYRequestData : NSObject

#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString  parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;
#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString  parameters:(id)parameters  success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
