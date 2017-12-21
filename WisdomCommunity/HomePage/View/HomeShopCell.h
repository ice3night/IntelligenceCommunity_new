//
//  HomeShopCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/22.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeShopCellDelegate
- (void) shopCellGotoShangCheng;
- (void) shopCellGotoRunCaiYuan;
@end
@interface HomeShopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *seperView;
@property (nonatomic,weak) id <HomeShopCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
