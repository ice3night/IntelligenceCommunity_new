//
//  YuyueTextFieldCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YuyueDetailModel.h"
@protocol YuyueFieldDelegate
- (void) contentEndEdit:(NSString *)str index:(NSString *)index;
@end
@interface YuyueTextFieldCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *contentField;
@property (nonatomic,strong) YuyueDetailModel *detailModel;
@property (nonatomic,copy) NSString *category;
@property (nonatomic,copy) NSString *index;

@property (nonatomic,weak) id <YuyueFieldDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
