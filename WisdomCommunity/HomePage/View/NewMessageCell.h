//
//  NewMessageCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/14.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCellFrame.h"
@interface NewMessageCell : UITableViewCell
@property (nonatomic, strong) MessageCellFrame *messageCellFrame;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
