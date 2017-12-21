//
//  FollowNoteCellFrame.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/17.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FollowNoteDO.h"
@interface FollowNoteCellFrame : NSObject
@property (nonatomic, assign) CGRect contentF;
@property (nonatomic, strong) FollowNoteDO *followNoteDO;
@property (nonatomic, assign) CGFloat cellHeight;
@end
