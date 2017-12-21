//
//  NewMallViewController.h
//  WisdomCommunity
//
//  Created by 咸国强 on 2017/12/16.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "JXBAdPageView.h"
#import "MallRecShop.h"
#import "ComMallView.h"
#import "TakeOutViewController.h"//外卖首页
#import "SearchViewController.h"//搜索框
#import "GoodsDetailsViewController.h"//商品详情
#import "TodayCMDCell.h"
@interface NewMallViewController : UIViewController
@property (nonatomic,strong) UICollectionView *collectionView;//商城tableview
@property (nonatomic,strong) NSArray *iconComMallArray;//按钮图标
@property (nonatomic,strong) NSArray *promptComMallArray;//按钮内容
@property (nonatomic,strong) NSMutableArray *recommendedMArray;//今日推荐
@property (nonatomic,strong) NSMutableArray *sourceArr;//今日热卖
@property (nonatomic,strong) UIButton *recommendedButton;//推荐
@property (nonatomic,strong) UIButton *SellLikeButton;//热销
@property (nonatomic,strong) JXBAdPageView *shufflingFigureView;//轮播图
@property (nonatomic,strong) NSArray *showImagesArry;//首页图片数据
@property (nonatomic,strong) MallRecShop *shop;
@property (nonatomic,strong) ComMallView *comMallView;//按钮视图

@end

