//
//  AddressCell.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/9.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressMangeModel.h"
@protocol OnClickEditDelegate <NSObject>
- (void) ClickEditImage:(NSString *)addressid;//
@end
@interface AddressCell : UITableViewCell
@property (nonatomic,copy) AddressMangeModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,weak) id<OnClickEditDelegate> delegate;//协议
@end
