//
//  FillFormDetail.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YuyueSelectCell.h"
#import "YuyueRadioVc.h"
#import "YuyueTextFieldCell.h"
@interface FillFormDetail : UITableViewController<YuyueSelectDelegate,YuyueSelectedDelegate,YuyueFieldDelegate>
@property (nonatomic,copy) NSString *themeId;
@end
