//
//  ComModel.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/1.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComModel : NSObject
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *comName;
@property (nonatomic,copy) NSString *comNo;
@property (nonatomic,copy) NSString *comTel;
@property (nonatomic,copy) NSString *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *introduction;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *longitude;
@end
