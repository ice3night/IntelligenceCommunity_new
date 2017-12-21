//
//  DetailProductModel.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/13.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailProductModel : NSObject
@property (nonatomic,copy) NSNumber *available;
@property (nonatomic,copy) NSNumber *busFee;
@property (nonatomic,copy) NSNumber *categoryId;
@property (nonatomic,copy) NSString *categoryName;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSNumber *discount;
@property (nonatomic,copy) NSNumber *averageStar;

@property (nonatomic,copy) NSString *discountPrice;
@property (nonatomic,copy) NSString *gmtCreate;
@property (nonatomic,copy) NSString *gmtModify;
@property (nonatomic,copy) NSNumber *groupon;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSString *imageStr;
@property (nonatomic,copy) NSString *images;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,copy) NSString *maxScoreRatio;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSNumber *order;
@property (nonatomic,copy) NSNumber *price;
@property (nonatomic,copy) NSNumber *score;
@property (nonatomic,copy) NSNumber *shopAccount;
@property (nonatomic,copy) NSNumber *shopId;
@property (nonatomic,copy) NSString *shopImg;
@property (nonatomic,copy) NSString *shopName;
@property (nonatomic,copy) NSString *slideshow;
@property (nonatomic,copy) NSNumber *successnum;
@property (nonatomic,copy) NSNumber *surplusNum;
@end
