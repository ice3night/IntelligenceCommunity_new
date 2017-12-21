//
//  MessagePModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  消息列表

#import <Foundation/Foundation.h>

@interface MessagePModel : NSObject

@property (nonatomic,copy) NSString * gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *comNo;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSNumber *publishTime;
@property (nonatomic,copy) NSString *publisher;


+ (instancetype) bodyWithDict:(NSDictionary *)dict;

@end
