//
//  ComBBSCellFrame.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/17.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "comBBSModel.h"
@interface ComBBSCellFrame : NSObject
@property (nonatomic, assign) CGRect iconF;
@property (nonatomic, assign) CGRect nameF;
@property (nonatomic, assign) CGRect contentF;
@property (nonatomic, assign) CGRect picF;
@property (nonatomic, assign) CGRect timeF;
@property (nonatomic, assign) CGRect deleteF;
@property (nonatomic, assign) CGRect popF;
@property (nonatomic, assign) CGRect priseBgF;
@property (nonatomic, assign) CGRect priseIvF;
@property (nonatomic, assign) CGRect priseNameF;
@property (nonatomic, assign) CGRect commentTableF;
@property (nonatomic, assign) float cellHeight;
@property (nonatomic, copy) NSMutableArray *frames;
@property (nonatomic, strong) comBBSModel *comBBSModel;
@end
