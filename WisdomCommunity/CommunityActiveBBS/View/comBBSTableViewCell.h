//
//  comBBSTableViewCell.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/9.
//  Copyright © 2016年 bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "comBBSModel.h"

@interface comBBSTableViewCell : UITableViewCell
typedef void(^Block)(NSString *);
@property (nonatomic, copy)   Block       delegateClicked;
//头像
@property (nonatomic,weak) UIImageView *headImage;
//用户名
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *timeLabel;
//来自
@property (nonatomic,weak) UILabel *contentLabel;
//展示内容图片
@property (nonatomic,weak) UIImageView *contentImageOne;
@property (nonatomic,weak) UIImageView *contentImageTwo;
@property (nonatomic,weak) UIImageView *contentImageThree;
//提示图片总数
@property (nonatomic,weak) UIImageView *promptImage;
@property (nonatomic,weak) UILabel *promptLabel;
//查看次数
@property (nonatomic,weak) UIButton *toViewButton;

//评论
@property (nonatomic,weak) UIButton *commentButton;
//点赞
@property (nonatomic,weak) UIButton *thumbUpButton;
//删除
@property (nonatomic,weak) UIButton *delegateButton;

@property (nonatomic,assign) BOOL wetherMyBBS;//是否是我的帖子
@property (nonatomic,strong) comBBSModel *model;

@end
