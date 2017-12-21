//
//  ProductDetailHeader.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/11.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailProductHeaderFrame.h"
@protocol ProductHeader
- (void) goMerchant:(NSString *)shopId;
@end
@interface ProductDetailHeader : UIView
@property (nonatomic, strong) DetailProductHeaderFrame *detailProductHeaderFrame;
@property (nonatomic,copy) NSString *finalPrice;
@property (nonatomic,copy) NSNumber *amount;

@property (nonatomic,weak) id <ProductHeader> delegate;
@property (nonatomic,copy) NSString *shopId;
@end
