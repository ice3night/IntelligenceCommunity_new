//
//  tuanModel.m
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "tuanModel.h"

@implementation tuanModel
+ (instancetype)gettuanmodelWithDict:(NSDictionary *)dict{
    
    
    tuanModel *model = [[tuanModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        
        self.name = dict[@"name"];
        //NSLog(@"name=%@",self.name);
        self.price = dict[@"price"];
        self.nowprice = dict[@"discountPrice"];
        self.num = dict[@"surplusNum"];
        self.image = dict[@"img"];
        self.cate = dict[@"categoryName"];
    }
    return self;
}
@end
