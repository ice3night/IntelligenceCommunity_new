//
//  RootViewController.h
//  WisdomCommunity
//   在别的设备登陆。 未登录
//  Created by bridge on 16/12/6.
//  Copyright © 2016年 bridge. All rights reserved.
//  主页

#import <UIKit/UIKit.h>
#import "JXBAdPageView.h"
#import "RootCTView.h"
#import "ActivityRootModel.h"
#import "comBBSTableViewCell.h"
#import "comBBSModel.h"
#import "PropertyViewController.h"//物业管家
#import "MessagePlistViewController.h"//消息列表
#import "ComAnnouncementViewController.h"//社区公告

#import "PostDetailsViewController.h"//帖子详情
#import "ActivityDetailsViewController.h"
#import "CYFromProgressView.h"
#import "MyCommunityListViewController.h"//小区
#import "CZExhibitionViewController.h"//油画,装潢展览
#import "UITapGestureRecognizer+UserInfo.h"//
#import "LoginViewController.h"
#import "ActivityRootModel.h"
#import "PropertyComplaint.h"
#import "NNSRootModelData.h"
#import "FillForm.h"
#import "HomeShopCell.h"
#import "HomeActivityCell.h"
#import "HomeTopCell.h"
#import "HomeMiddleCell.h"
@interface RootViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,OnClickCollectionDelegate,CAAnimationDelegate,HomeTopCellDelegate,HomeMiddleCellDelegate,HomeShopCellDelegate,HomeActivityCellDelegate>
@property (nonatomic,strong) UITableView *RootSTableView;//首页展示tableview
@property (nonatomic,weak) UIImageView *showActivityImmage;
@property (nonatomic,weak)   UIImageView *OilImageView;//油画
@property (nonatomic,weak)   UIImageView *DecorationImageView;//装潢
@property (nonatomic,strong) CYEmitterButton *signInBtn;//签到按钮
@property (nonatomic,assign) BOOL whetherSignIn;//是否已签到
@property (nonatomic,strong) NSDictionary *ShowImagesDict;//首页图片数据
@property (nonatomic,strong) NSDictionary *ActivityDict;//活动
@property (nonatomic,strong) NSArray *imgAddressArray;//图片
@property (nonatomic,strong) ActivityRootModel *activityModel;

@property (nonatomic,strong) comBBSTableViewCell *cell;
@property (nonatomic,strong) JXBAdPageView *ShufflingFigureView;//轮播图
@property (nonatomic,strong) RootCTView *ctView;//按钮

@property (nonatomic,strong) UIButton *communityButton;//定位小区

//两种不同的CAEmitterLayer
@property (strong, nonatomic) CAEmitterLayer *chargeLayer;
@property (strong, nonatomic) CAEmitterLayer *explosionLayer;

@end
