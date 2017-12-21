//
//  HomeMiddleCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/22.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeMiddleCellDelegate
- (void) gotoRenzheng;
- (void) gotoYuyue;
- (void) gotoTiandan;
- (void) goToJianshen;
- (void) goToBiyouxin;
@end
@interface HomeMiddleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *renzhengView;
@property (nonatomic,weak) id <HomeMiddleCellDelegate> delegate;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
