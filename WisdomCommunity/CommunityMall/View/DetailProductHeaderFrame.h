//
//  DetailProductHeaderFrame.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/13.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailProductModel.h"
@interface DetailProductHeaderFrame : NSObject
@property (nonatomic, assign) CGRect slideShowF;
@property (nonatomic, assign) CGRect titleF;
@property (nonatomic, assign) CGRect featureF;
@property (nonatomic, assign) CGRect priceF;
@property (nonatomic, assign) CGRect salesCountF;
@property (nonatomic, assign) CGRect tipF;
@property (nonatomic, assign) CGRect salesF;
@property (nonatomic, assign) CGRect scoresF;

@property (nonatomic, assign) CGRect numtipF;
@property (nonatomic, assign) CGRect shaopViewF;
@property (nonatomic, assign) CGRect shopParentViewF;
@property (nonatomic, assign) CGRect shopImageF;
@property (nonatomic, assign) CGRect shopNameF;
@property (nonatomic, assign) CGRect proNumF;
@property (nonatomic, assign) CGRect evaluateTipF;
@property (nonatomic, assign) CGRect evaluateF;
@property (nonatomic, assign) CGRect tipViewF;
@property (nonatomic, strong) NSMutableArray *frameArray;
@property (nonatomic, assign) CGRect detailF;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) DetailProductModel *detailProductModel;
@end
