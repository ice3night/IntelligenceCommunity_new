//
//  MyComplantsTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/14.
//  Copyright © 2016年 bridge. All rights reserved.
//  我的投诉

#import <UIKit/UIKit.h>
#import "MyComplaintsModel.h"
@interface MyComplantsTableViewCell : UITableViewCell

@property (nonatomic,weak) UIImageView *promptImage;
@property (nonatomic,weak) UILabel *promptLabel;
@property (nonatomic,weak) UILabel *resultLabel;
@property (nonatomic,weak) UILabel *timeLabel;

@property (nonatomic,strong) MyComplaintsModel *model;

@end
