//
//  tuanModel.h
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface tuanModel : NSObject
@property (weak, nonatomic)  UIImageView *image;
@property (weak, nonatomic)  UILabel *name;
@property (weak, nonatomic)  UILabel *num;
@property (weak, nonatomic)  UILabel *price;
@property (weak, nonatomic)  UILabel *cate;
@property (weak, nonatomic)  UILabel *nowprice;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)gettuanmodelWithDict:(NSDictionary *)dict;
@end
