//
//  CommunityABBSViewController.h
//  WisdomCommunity
//
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//  社区大小事主页

#import <UIKit/UIKit.h>
#import "comBBSTableViewCell.h"
#import "BBSRootViewController.h"//帖子
#import "ActicityRootViewController.h"
#import "ComBBSCellFrame.h"
#import "ComBBSCell.h"
#import "ReplyInputView.h"
#define padding 10

@interface CommunityABBSViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,PopDelegate,ReplyViewDelegate>
@property (nonatomic,strong) UITableView *comBBSTableView;//tableview
@property (nonatomic,weak) UIImageView *showImmage;//帖子
@property (nonatomic,weak) UIButton *publishBtn;//话题
@property (nonatomic,strong) NSMutableArray *comModelBBSarray;//数据模型
@property (nonatomic,assign) NSInteger recordRequesPage;//记录请求页数
@property (nonatomic,strong) NSArray *ClickPRootCellData;//点击cell数据

@property (nonatomic,strong) comBBSTableViewCell *cell;//帖子列表
@property (nonatomic,strong) NSString *type;//1加载更多，0其他

@end
