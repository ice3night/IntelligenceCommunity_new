//
//  ScoreModel.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/7.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreModel : NSObject
@property (nonatomic,copy) NSString *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSNumber *money;
@end
