//
//  HomeTopCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeTopCellDelegate
- (void) goToIntelligent;
- (void) goToRepair;
- (void) goToComplaint;
- (void) goToShangcheng;
@end
@interface HomeTopCell : UITableViewCell
@property (nonatomic,weak) id <HomeTopCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
