//
//  HomeActivityCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/22.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeActivityCellDelegate
- (void) shopActivityAction;
@end
@interface HomeActivityCell : UITableViewCell
@property (nonatomic,weak) id <HomeActivityCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *topbg;
@property (nonatomic,copy) NSString *url;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
