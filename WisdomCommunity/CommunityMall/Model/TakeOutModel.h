//
//  TakeOutModel.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/19.
//  Copyright © 2016年 bridge. All rights reserved.
//  外卖-超市等

#import <Foundation/Foundation.h>

@interface TakeOutModel : NSObject
@property (nonatomic,strong) NSString *headString;//头像
@property (nonatomic,strong) NSNumber *available;
@property (nonatomic,strong) NSString *busFee;
@property (nonatomic,strong) NSNumber *categoryId;
@property (nonatomic,strong) NSString *categoryName;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSNumber *discount;
@property (nonatomic,strong) NSNumber *discountPrice;
@property (nonatomic,strong) NSString *gmtCreate;
@property (nonatomic,strong) NSString *gmtModify;
@property (nonatomic,strong) NSNumber *groupon;
@property (nonatomic,strong) NSNumber *id;
@property (nonatomic,strong) NSString *imageStr;
@property (nonatomic,strong) NSString *images;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *intro;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSNumber *order;
@property (nonatomic,strong) NSNumber *price;
@property (nonatomic,strong) NSNumber *score;
@property (nonatomic,strong) NSString *shopAccount;
@property (nonatomic,strong) NSNumber *shopId;
@property (nonatomic,strong) NSString *shopImg;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *slideshow;
@property (nonatomic,strong) NSNumber *successnum;
@property (nonatomic,strong) NSNumber *surplusNum;
@end
