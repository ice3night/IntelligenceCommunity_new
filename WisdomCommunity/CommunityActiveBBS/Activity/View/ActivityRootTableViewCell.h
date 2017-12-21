//
//  ActivityRootTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/15.
//  Copyright © 2016年 bridge. All rights reserved.
//  活动首页cell

#import <UIKit/UIKit.h>
#import "ActivityRootModel.h"
@interface ActivityRootTableViewCell : UITableViewCell
typedef void(^Block)(NSString *);
@property (nonatomic, copy)   Block       delegateActivityClicked;

@property (nonatomic,weak) UIImageView *imageImageView;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UIImageView *statusImgView;

@property (nonatomic,weak) UILabel *contentLabel;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UIImageView *stateImageView;
@property (nonatomic,weak) UIImageView *showImageView;
@property (nonatomic,weak) UIButton *delegateAButton;

@property (nonatomic,assign) BOOL whetherDelegateActivity;//是否删除活动
@property (nonatomic,strong) ActivityRootModel *model;

@end
