//
//  NormalCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/4.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComModel.h"
@interface NormalCell : UITableViewCell
@property (nonatomic,strong) ComModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
