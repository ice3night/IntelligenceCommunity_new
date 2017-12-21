//
//  weiModel.h
//  WisdomCommunity
//
//  Created by born2try-1 on 2017/12/18.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weiModel : NSObject
@property (weak, nonatomic)  UIImageView *shopimage;
@property (weak, nonatomic)  UILabel *shopname;
@property (weak, nonatomic)  UILabel *number;
@property (weak, nonatomic)  UILabel *firstpay;
@property (weak, nonatomic)  UILabel *sendmoney;
@property (weak, nonatomic)  UILabel *manjian;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)gettweimodelWithDict:(NSDictionary *)dict;
@end
