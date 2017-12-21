//
//  OrderMModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/12.
//  Copyright © 2016年 bridge. All rights reserved.
//  订单主页模型

#import <Foundation/Foundation.h>

@interface OrderMModel : NSObject
@property (nonatomic,copy) NSString *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *shopId;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSNumber *totalMoney;
@property (nonatomic,copy) NSNumber *nowMoney;
@property (nonatomic,copy) NSString *process;
@property (nonatomic,copy) NSString *receiver;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSNumber *busFee;
@property (nonatomic,copy) NSString *details;
@property (nonatomic,copy) NSString *shopImg;
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,copy) NSDictionary *detailList;
@end
