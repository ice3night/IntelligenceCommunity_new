//
//  comBBSModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface comBBSModel : NSObject
@property (nonatomic,copy) NSNumber *praiseState;
@property (nonatomic,copy) NSNumber *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSNumber *category;
@property (nonatomic,copy) NSString *imgAddress;
@property (nonatomic,copy) NSString *comNo;
@property (nonatomic,copy) NSString *isDel;
@property (nonatomic,copy) NSNumber *viewCount;
@property (nonatomic,copy) NSNumber *replyCount;
@property (nonatomic,copy) NSNumber *praiseCount;
@property (nonatomic,copy) NSDictionary *accountDO;
@property (nonatomic,copy) NSString *communityName;
@property (nonatomic,copy) NSString *accountName;
@property (nonatomic,copy) NSString *flag;
@property (nonatomic,copy) NSDictionary *notePraiseDo;
@property (nonatomic,copy) NSDictionary *followNoteDO;
@end
