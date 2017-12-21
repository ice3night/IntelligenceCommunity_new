//
//  ComAnnoTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/8.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区公告

#import <UIKit/UIKit.h>
#import "ComAnnoModel.h"
@interface ComAnnoTableViewCell : UITableViewCell


//内容，时间
@property (nonatomic,weak) UILabel *comAnnLabel;
@property (nonatomic,weak) UILabel *timeLabel;

@property (nonatomic,strong) ComAnnoModel *model;

@end
