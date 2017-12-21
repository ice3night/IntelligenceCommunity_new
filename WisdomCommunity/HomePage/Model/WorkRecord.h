//
//  WorkRecord.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/25.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkRecord : NSObject
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *scanName;
@property (nonatomic,copy) NSNumber *profession;
@property (nonatomic,copy) NSNumber *status;
@property (nonatomic,copy) NSNumber *createTime;
@property (nonatomic,copy) NSString *qrCodeContent;
@property (nonatomic,copy) NSString *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSNumber *codeId;
@end
