//
//  MyActivity.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/11/25.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "ViewController.h"
#import "SendActivityViewController.h"
#import "ActivityDetailsViewController.h"
#import "ActivityRootTableViewCell.h"

@interface MyActivity : ViewController<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView               *ActivityRootTableView;    //个人中心tableview
@property (nonatomic, strong) UIButton                  *participateButton;        //参与
@property (nonatomic, strong) UIButton                  *releaseButton;            //发布
@property (nonatomic,strong) UIImageView *verticalImmage;


@property (nonatomic,assign) BOOL whetherClickLabelRequest;//是否是点击了标签栏进行的数据请求，YES：不提示没有数据；NO：提示没有数据

@property (nonatomic, strong) UIImageView               *postingImmage;//发布活动按钮
@property (nonatomic, strong) ActivityRootTableViewCell *cell;

@property (nonatomic,assign) BOOL whetherFirst;//是否是第一次访问
//初始
@property (nonatomic,assign)  NSInteger currentAllPage;//列表
@property (nonatomic, strong) NSMutableArray *modelActivityRootarray;   //数据模型
//发布列表
@property (nonatomic,assign)  NSInteger currentReleasePage;
@property (nonatomic, strong) NSMutableArray *myReleaseArray;//模型
//参与列表
@property (nonatomic,assign)  NSInteger currentParticipatePage;
@property (nonatomic, strong) NSMutableArray *myParticipateArray;//模型

@property (nonatomic, strong) UIImageView *ActicityPromptImage;//提示

@end
