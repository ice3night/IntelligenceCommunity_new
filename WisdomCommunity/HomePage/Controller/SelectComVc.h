//
//  SelectComVc.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/3.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComModel.h"
@protocol ComDelegate
- (void) getCom:(ComModel *)model;
@end
@interface SelectComVc : UIViewController
@property (nonatomic,weak) id <ComDelegate> delegate;
@end
