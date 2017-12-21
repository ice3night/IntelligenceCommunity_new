//
//  YuyueRadioVc.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YuyueSelectedDelegate
- (void) selected:(NSString *)name index:(NSString *)index;
@end
@interface YuyueRadioVc : UITableViewController
@property (nonatomic,copy) NSString *option;
@property (nonatomic,copy) NSString *vcName;
@property (nonatomic,copy) NSString *index;

@property (nonatomic, copy) NSMutableArray *options;
@property (nonatomic,weak) id <YuyueSelectedDelegate> delegate;

@end
