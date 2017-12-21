//
//  weiModel.m
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "weiModel.h"

@implementation weiModel
+ (instancetype)getweimodelWithDict:(NSDictionary *)dict{
    
    
    weiModel *model = [[weiModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    self = [super init];
//    if (self) {
//
//        self.shopname = dict[@"name"];
//        //NSLog(@"name=%@",self.name);
//        self.price = dict[@"price"];
//        self.nowprice = dict[@"discountPrice"];
//        self.number = dict[@"surplusNum"];
//        self.shopimage = dict[@"img"];
//        self.cate = dict[@"categoryName"];
//    }
//    return self;
//}
@end
