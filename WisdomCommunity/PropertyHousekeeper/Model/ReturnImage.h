//
//  ReturnImage.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/10/31.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnImage : NSObject
@property (nonatomic,copy) NSString *error;
@property (nonatomic,copy) NSString *list;
@property (nonatomic,copy) NSString *msg;
@property (nonatomic,copy) NSString *returnValue;
@property (nonatomic,copy) NSDictionary *param;
@end
