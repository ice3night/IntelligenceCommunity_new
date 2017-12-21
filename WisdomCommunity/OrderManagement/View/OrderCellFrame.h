//
//  OrderCellFrame.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/16.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderMModel.h"
@interface OrderCellFrame : NSObject
@property (nonatomic, assign) CGRect topBgF;
@property (nonatomic, assign) CGRect headImageF;
@property (nonatomic, assign) CGRect nameF;
@property (nonatomic, assign) CGRect timeF;
@property (nonatomic, assign) CGRect priceF;
@property (nonatomic, assign) CGRect lineF;
@property (nonatomic, assign) CGRect tableF;
@property (nonatomic, strong) OrderMModel *orderModel;
@property (nonatomic, assign) CGFloat cellHeight;
@end
