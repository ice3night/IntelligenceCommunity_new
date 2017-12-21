//
//  ProductModel.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/13.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property (nonatomic,copy) NSString *shopImg;
@property (nonatomic,copy) NSString *shopAccount;
@property (nonatomic,copy) NSString *slideshow;
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
@property (nonatomic,copy) NSNumber *order;
@property (nonatomic,copy) NSString *score;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *imageStr;
@end
