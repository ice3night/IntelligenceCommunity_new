//
//  ProductCateCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/26.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakeOutModel.h"
@interface ProductCateCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) TakeOutModel *model;
@end
