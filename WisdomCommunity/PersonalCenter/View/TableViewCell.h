//
//  TableViewCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/7.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HouseModel.h"
@interface TableViewCell : UITableViewCell
@property (nonatomic,copy) HouseModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
