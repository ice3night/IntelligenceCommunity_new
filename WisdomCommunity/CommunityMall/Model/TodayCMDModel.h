//
//  TodayCMDModel.h
//  WisdomCommunity
//
//  Created by legend on 2017/10/12.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayCMDModel : NSObject
@property (nonatomic, strong) NSString *gmtCreate;
@property (nonatomic, strong) NSString *gmtModify;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSNumber *successnum;
@property (nonatomic, strong) NSString *available;
@property (nonatomic, strong) NSNumber *order;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) NSString *maxScoreRatio;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *imageStr;
@property (nonatomic, strong) NSString *images;
@property (nonatomic, strong) NSString *slideshow;
@property (nonatomic, strong) NSString *shopImg;
@property (nonatomic, strong) NSString *shopAccount;
@property (nonatomic, strong) NSString *busFee;
@end
