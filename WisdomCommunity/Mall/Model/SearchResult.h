//
//  SearchResult.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject
@property (nonatomic,copy) NSString *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *shopId;
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *categoryId;
@property (nonatomic,copy) NSString *categoryName;
@property (nonatomic,copy) NSNumber *price;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSNumber *successnum;
@property (nonatomic,copy) NSString *available;
@end
