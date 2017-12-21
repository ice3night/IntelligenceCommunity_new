//
//  ComplaintCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComplaintCellFrame.h"
@interface ComplaintCell : UITableViewCell
@property (nonatomic, strong) ComplaintCellFrame *complaintCellFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
