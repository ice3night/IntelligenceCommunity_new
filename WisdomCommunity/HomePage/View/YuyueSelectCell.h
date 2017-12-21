//
//  YuyueSelectCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YuyueDetailModel.h"
@protocol YuyueSelectDelegate
- (void) touchAndselect:(YuyueDetailModel *)model;
@end
@interface YuyueSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,weak) id <YuyueSelectDelegate> delegate;
@property (nonatomic,copy) NSString *choiceStr;
@property (nonatomic,copy) YuyueDetailModel *detailModel;
@end
