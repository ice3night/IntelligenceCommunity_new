//
//  ActivityRootModel.m
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import "ActivityRootModel.h"
NSString *const kReturnValueId = @"id";
NSString *const kReturnValuePraiseCount = @"praiseCount";
NSString *const kReturnValueAccountDO = @"accountDO";
NSString *const kReturnValueCommunityName = @"communityName";
NSString *const kReturnValuePlayCount = @"playCount";
NSString *const kReturnValueGmtCreate = @"gmtCreate";
NSString *const kReturnValueImgAddress = @"imgAddress";
NSString *const kReturnValueGmtModify = @"gmtModify";
NSString *const kReturnValueAddress = @"address";
NSString *const kReturnValueViewCount = @"viewCount";
NSString *const kReturnValueAcTime = @"acTime";
NSString *const kReturnValueComNo = @"comNo";
NSString *const kReturnValueAccount = @"account";
NSString *const kReturnValueReplyCount = @"replyCount";
NSString *const kReturnValueContent = @"content";
NSString *const kReturnValueTitle = @"title";
NSString *const kReturnValueFlag = @"flag";


@implementation ActivityRootModel

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.activityID    = [self objectOrNilForKey:kReturnValueId            fromDictionary:dict];
        self.praiseCount   = [self objectOrNilForKey:kReturnValuePraiseCount   fromDictionary:dict];
        self.accountDO     = [self objectOrNilForKey:kReturnValueAccountDO     fromDictionary:dict];
        self.communityName = [self objectOrNilForKey:kReturnValueCommunityName fromDictionary:dict];
        self.playCount     = [self objectOrNilForKey:kReturnValuePlayCount     fromDictionary:dict];
        self.gmtCreate     = [self objectOrNilForKey:kReturnValueGmtCreate     fromDictionary:dict];
        self.imgAddress    = [self objectOrNilForKey:kReturnValueImgAddress    fromDictionary:dict];
        self.gmtModify     = [self objectOrNilForKey:kReturnValueGmtModify     fromDictionary:dict];
        self.address       = [self objectOrNilForKey:kReturnValueAddress       fromDictionary:dict];
        self.viewCount     = [self objectOrNilForKey:kReturnValueViewCount     fromDictionary:dict];
        self.acTime        = [self objectOrNilForKey:kReturnValueAcTime        fromDictionary:dict];
        self.comNo         = [self objectOrNilForKey:kReturnValueComNo         fromDictionary:dict];
        self.account       = [self objectOrNilForKey:kReturnValueAccount       fromDictionary:dict];
        self.replyCount    = [self objectOrNilForKey:kReturnValueReplyCount    fromDictionary:dict];
        self.content       = [self objectOrNilForKey:kReturnValueContent       fromDictionary:dict];
        self.title         = [self objectOrNilForKey:kReturnValueTitle         fromDictionary:dict];
        self.flag          = [self objectOrNilForKey:kReturnValueFlag         fromDictionary:dict];
        self.stateString   = [ActivityDetailsTools returnStateString:self.acTime];
    }
    return self;
}


+ (instancetype) bodyWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
