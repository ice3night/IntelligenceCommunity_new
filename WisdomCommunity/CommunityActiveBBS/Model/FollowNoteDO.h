//
//  FollowNoteDO.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/17.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FollowNoteDO : NSObject
@property (nonatomic,copy) NSString *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *noteId;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *accountDO;
@property (nonatomic,copy) NSString *accountName;
@property (nonatomic,copy) NSString *maxWidth;
@property (nonatomic,copy) NSNumber *state;
@property (nonatomic,copy) NSNumber *requesterId;
@property (nonatomic,copy) NSString *requesterName;
@property (nonatomic,copy) NSString *requesterAccount;
@end
