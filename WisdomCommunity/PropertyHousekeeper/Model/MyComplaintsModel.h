//
//  MyComplaintsModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的投诉

#import <Foundation/Foundation.h>

@interface MyComplaintsModel : NSObject

@property (nonatomic,strong) NSString *timeString;//时间
@property (nonatomic,strong) NSString *promptImageString;//
@property (nonatomic,strong) NSString *promptString;//
@property (nonatomic,strong) NSString *resultString;//

+ (instancetype) bodyWithDict:(NSDictionary*)dict;
@end
