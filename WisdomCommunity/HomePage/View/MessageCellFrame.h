//
//  MessageCellFrame.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessagePModel.h"
@interface MessageCellFrame : NSObject
@property (nonatomic, assign) CGRect bgViewF;
@property (nonatomic, assign) CGRect topBgF;
@property (nonatomic, assign) CGRect iconF;
@property (nonatomic, assign) CGRect titleF;
@property (nonatomic, assign) CGRect lineF;
@property (nonatomic, assign) CGRect contentF;
@property (nonatomic, assign) CGRect detailF;
@property (nonatomic, assign) CGRect timeF;
@property (nonatomic, strong) MessagePModel *messagePModel;
@property (nonatomic, assign) CGFloat cellHeight;
@end
