//
//  OrderItem.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/16.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderItem : NSObject
@property (nonatomic,copy) NSString *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *orderId;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSNumber *price;
@property (nonatomic,copy) NSNumber *total;
@property (nonatomic,copy) NSNumber *productnum;
@end
