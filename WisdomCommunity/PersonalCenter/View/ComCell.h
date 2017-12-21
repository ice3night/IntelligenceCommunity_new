//
//  ComCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/8.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeComModel.h"
@protocol ComChangeDelegate
- (void) change:(ChangeComModel *)model;
@end
@interface ComCell : UITableViewCell
@property (nonatomic,copy) ChangeComModel *model;
@property (nonatomic,weak) id <ComChangeDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
