//
//  ShopComment.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/11.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountDo.h"
@interface ShopComment : NSObject
@property (nonatomic,copy) NSString *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *shopId;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *evaluate;
@property (nonatomic,copy) NSNumber *productStar;
@property (nonatomic,copy) NSNumber *serveStar;
@property (nonatomic,copy) AccountDo *accountDO;
@end
