//
//  ComplaintModel.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplaintModel : NSObject
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *user;
@property (nonatomic,copy) NSNumber *category;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *imgAddress;
@property (nonatomic,copy) NSString *reason;
@property (nonatomic,copy) NSNumber *callTime;
@property (nonatomic,copy) NSNumber *dealTime;
@property (nonatomic,copy) NSNumber *status;
@end
