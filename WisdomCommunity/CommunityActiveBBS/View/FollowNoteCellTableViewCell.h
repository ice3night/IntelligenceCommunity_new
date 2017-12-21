//
//  FollowNoteCellTableViewCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/17.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowNoteCellFrame.h"

@interface FollowNoteCellTableViewCell : UITableViewCell
@property (nonatomic, weak) UITextView *detailView;
@property (nonatomic, strong) FollowNoteCellFrame *followNoteCellFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
