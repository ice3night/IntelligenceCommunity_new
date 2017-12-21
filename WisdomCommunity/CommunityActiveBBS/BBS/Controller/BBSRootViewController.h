//
//  BBSRootViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/13.
//  Copyright © 2016年 bridge. All rights reserved.
//  论坛主页

#import <UIKit/UIKit.h>
#import "comBBSTableViewCell.h"
#import "BBSRootViewController.h"//帖子
#import "ActicityRootViewController.h"
#import "ComBBSCellFrame.h"
#import "ComBBSCell.h"
#import "ReplyInputView.h"
@interface BBSRootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,PopDelegate,ReplyViewDelegate>
@property (nonatomic,strong) UITableView *comBBSTableView;//tableview
@property (nonatomic,weak) UIImageView *showImmage;//帖子
@property (nonatomic,weak) UIButton *topicButton;//话题
@property (nonatomic,strong) NSMutableArray *comModelBBSarray;//数据模型
@property (nonatomic,assign) NSInteger recordRequesPage;//记录请求页数
@property (nonatomic,strong) NSArray *ClickPRootCellData;//点击cell数据

@property (nonatomic,strong) comBBSTableViewCell *cell;//帖子列表@end
@end
